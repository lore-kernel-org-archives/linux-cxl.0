Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D428F5
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224816; cv=none; b=a7eoHowTHopQmgEGUXQPpaJvVvydVgH7XRhA7hfsNVjfMsOa7bF+VmpDfsGeag01QlduN7+rsnpEyxB36i4YkHS0FLClw/7yORSpfzlAyowgtdT8b3FPG+S7BQBM3zdXYKoXFGfS/qDUmFjxXe0mlq4GLt9JxAPH6qAF6jdIUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224816; c=relaxed/simple;
	bh=7Yw8TRdsC8iJj4zKIDBj3vysMEmn/ITvAglewvj0fLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqKow1ZNfWomsPbkMz0WwGuHhwCz1Lb06kJY11YE5op8WU39QvqAg/xvqonkzsS2krGXUhWwrpjaXXU/m07VzTw3tAe2WinkPHNeS2wOqbA+Gj+cMesXYmWShLzepz1/EW9mGmSybURWT4QqDLzYnkFXiRc8CMfItPBYGYKTL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6xOKA11; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6xOKA11"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e7391839cso447347a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224814; x=1788829614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=B6xOKA11WJKxu65gr0+Eo+Iyjosqjzcw6ONOIKWZ+sS4pk+1h9yL3lGup3YQISDg/z
         irW410TFAsrUzP38hX+sez7x2uJ04GH/cOVK8h0yV7ZUqhB3fF/ztuUudpnhdNK1atW1
         CTxBMvDvvuHhLHu8+OYW+GNCcY6Ij2BdE9ywcFcOrRVOC72W1xY5NTJ9S2+jC6lhO7kb
         k5TT9p+jcnub7Ief5RE6rXcOOA1suNtQs707UmAvqvysAL/lR2OsjTXh2R3OmvsDs81J
         2x7JUKaDn3VQRiUh1wgXsUzZO1yo5Sn6hg/PglZuJV33v03aRji/whjoapnJB3mlWLYU
         gUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224814; x=1788829614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=setNa7usjUzf5OVT0u6mQmAtwY72vIxNMtpUJK2/b57wGaNotX4AdauMLLOWES5EHr
         C337GpjZsR9iEeyzk45w3ptTpqi8x5m1Qdye7ZsYMCXkiMf8/Y9CsnQivF0x2N+4NM3/
         FxAeSd9Q4pMprL5vVzA1LZFI4GKgPuOxrW53P95npC1jBnEb7GYJ1MAWliA4STzRqTth
         PKSmbNSHTBdL+cdUfUTkOhlMVYPDs8hggNygaTH4lGhrE5jQbBehhiTpHH7/eR2N4jW3
         CVIpeZ038cLSMdksjlvk8tPICHYxvQhIXqaVlH95QKUVssSSQAzhaQNQRJoz4vlYrS3W
         +SZA==
X-Forwarded-Encrypted: i=1; AKwUvBx7rdxcP0mbTfRUKADWVj/MGBTH6BBSAGmelJYfRZGKLQ3iB6ymH+1GD0qzJEV7jTV3/46v+ylqF7o=@vger.kernel.org
X-Gm-Message-State: AFuF++mwLl6mHDB/RYW4FCiGa6nWm34H7nHnAylh2NAVna37mncxBJs+
	mHhT2nehGyIlB+yjHd3+jqebt5+AVvli1K9DdQBObg4IWWmNoviUmdB3
X-Gm-Gg: AYBFou17EILIg8HPREHAEGI/Cn/nO1xm+NNHYaU5HYfCsIqwyl9eKrV4M72mGo6LKRx
	JSDmKWWSo5/sFdn+lrvbAPwrGVW7BQkgSNs/C/qC+14/c/eVhTVL8UcH+jPl9MJ9ig1hA7Gf7p+
	I0LrWQalCO5MWD5VVY1VYqzo4hLpascgQa2PmK6y73kAIEHjUeILH+9yptSrZa5NC3LYe6qykOo
	TEXn7u5xUjtbkT5JiOe7/5XZPcAWt2jc9HEoXUhJrfTJd9g9S13CvUjp6+zrFm26FdkNxsiZj1G
	5UZuBFmt8zYXTSeKIh2lASlEWvheqY4LfV35ZQ1V2XbarvjEHr2CqLerhBfSQVc09Z9bPdMhsyK
	3YRiHtMbEt0Cs/bvSzAn2i566QY2HySAqmYn1zDVPAwXQGKHHo0XC/iMY3LRzMtPnTJmLEWGlii
	U9TCnysxsnlNIrbi3fixTwhPVKldZ/3f42aQdGc4iVJoSeUvq+adwLmeoBpcBYwC2EI+swPPn0g
	pv4KQ==
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr49611662a91.14.1788224814428;
        Mon, 31 Aug 2026 18:06:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com
Subject: [PATCH v3 20/21] rust: allow extracting the buffer from a CString
Date: Tue,  1 Sep 2026 11:03:46 +1000
Message-ID: <20260901010347.2614656-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper around a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a556788bcc5e..3fd8a218547f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    #[inline]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.55.0

