if User.count.zero?
  User.create email: 'lucky@google.com', name: '轩辕剑神', role: :admin, password: '123456789'
end