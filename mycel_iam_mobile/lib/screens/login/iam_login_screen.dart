import 'package:flutter/material.dart';

/// Exported for use by other apps (project_x, etc.).
///
/// Plain widget. Calls [onAuthenticated] with a token on success.
/// Has NO dependency on the shell or any module.
class IamLoginScreen extends StatefulWidget {
  final void Function(String token) onAuthenticated;

  const IamLoginScreen({required this.onAuthenticated, super.key});

  @override
  State<IamLoginScreen> createState() => _IamLoginScreenState();
}

class _IamLoginScreenState extends State<IamLoginScreen> {
  bool _isOtp = false;
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    setState(() => _loading = true);
    try {
      // TODO: Call IAM auth API
      await Future.delayed(const Duration(seconds: 1));
      final token = 'iam_token_${DateTime.now().millisecondsSinceEpoch}';
      widget.onAuthenticated(token);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mycel Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 64, color: theme.colorScheme.primary),
            const SizedBox(height: 32),

            // Mode toggle
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Password')),
                ButtonSegment(value: true, label: Text('OTP')),
              ],
              selected: {_isOtp},
              onSelectionChanged: (v) => setState(() => _isOtp = v.first),
            ),
            const SizedBox(height: 24),

            // Fields
            if (!_isOtp) ...[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ] else ...[
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
            const SizedBox(height: 24),

            // Submit
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _handleSignIn,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isOtp ? 'Send Code' : 'Sign In'),
              ),
            ),
            const SizedBox(height: 16),

            // OIDC
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _loading ? null : _handleSignIn,
                child: const Text('Login with OIDC'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
