Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7C343D63
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780624; cv=none; b=Kf5Mx1+99I3yffGsdDNngJpLNHsmjNbcNLae8yvmnPtaIBtI5QttutIoTXVc+6053AG4ROxWIVYesIRWj/ppvYFo5WziiHDD91fc/Z56bijpUJy5LBSafx7zeyJ5MYNy2Qvj4OH4LjEXPVk2L/Va2hn7vIrK6UhZ4rdB6xu51GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780624; c=relaxed/simple;
	bh=CmwKf7zbMS8N3K/wJq8ojeQQeHe1E74I8u66XXYuYnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWSeSlqiMjUSKRQwzIcb+IA5SmfJs4wxr7x/OsOurqyXa0RiRtYZ7J8txCK4JOtU5E0Mn3X4akVqJmZjvrtKH12UgygSBtPWyyGWQ8v3mFqpQ54F1/XrkOP0Vfy3Ii2NFlrNFbKN1iwlzKuJM8XoDknHf+jjZocA49ZQrFfqUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJR2FQNe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJR2FQNe"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e1837e053so182267a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780623; x=1771385423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wadzZAQKDnG/6H+AFZHuWAhAOhXcknipq6nDnMb1Z+c=;
        b=PJR2FQNeHOJhP4on+3hI5sPz7IVtDNiZsIREurNI0H5fYMtaDZ90jBBSiaEprSGd1E
         7RkeLvvwUMGa6yH4sNRXFBTDuIMWDkS/PxsNrtbirzVAgP15Kc3QuS22km1CUVwKj66L
         vtOzNvAdwikyf2/Z/eQZWkAVrUTXJykNMqJ/DB8UbMaXGNnTEE+vJXN3XlEybAoFC7IM
         c5LkM7QzuSpAjAjood9xMtzqvCUb2jOqz0KT74Qg5XvISlq9n9fJDIpzruKU8OJv4k68
         qwDtudv//pJtpKBUiPO4+7Z0swXZuQeU4WDTmpyLrHDmS1MHkvX7i7+NBZu25Wr0lOJq
         1WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780623; x=1771385423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wadzZAQKDnG/6H+AFZHuWAhAOhXcknipq6nDnMb1Z+c=;
        b=EQOBJBD3o4OyI2DKeTx+hwy++jcglhFn0hnDeOV/ibRzn7rxJRHiSURIAMVD559IMp
         5tJMfHp8CbUoKeXUa/XLHYYNFzj4Pvo6Bwz7QNyYm6ohIoLF5ZgUJ1PFr//igqATm0w6
         shCeOHbWG6F8H0yibl6UaOyIHXGAu8Gojqex9zUUws7LFAQFMpZTCbxe+8lZCXWwwdtw
         L200UpLrceQ2+5Y0jxp4i1T8lFylN4IJTgmB6ITz/PT50QsA75Crw/VzBvUTqZ7DgXrJ
         ThBaeXDbAKrklyq8REsrssz//FnnII0uoG7GQDoGl7leP9R1ErmngGmoGOAFj4kScyDx
         ztrA==
X-Forwarded-Encrypted: i=1; AJvYcCX9pGAy6WNuiySZMI6g5ndR4ZbpzJ5a7ZRk5fH/xmFCWjTH35vVf97K3v3MFimAtfQPqvqSgDlLN/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUMnYvJS3dMw6U5PGH/NPAuMp26UeVyVaE7GSSRVbezRaqVOV
	RaTnVcHZ8k1OnVMt8UPFEtEyKxktzdk8xAW5xtrPfu/CR0XaX7bLvbwG
X-Gm-Gg: AZuq6aLvrwce80guaEDbgsSx11xIcoUd2y2Gtr1thT+D+oAGpmLvZ6Lv0yfDvgcBghU
	On0cMldZmnorLie6I22cIvHsLMIoXqH5CA2S96QEJTt6ldqKDTDhoea7IHIEIZq8F6IvOIFfjCS
	dUUBvzx4fKup1nlcXpPbyMWduOCqji1xZ+SR6rW46U+dnhHl5CsojFH+vA/e2a/LK3aOg7i4Ko9
	F9ot+mUIIICmyk/J3ygjh3JAGbCMWk9C0A4yd4x4wQf/ADwShcA73Hw15zNQ6+DES2kMr0a1/ov
	mNzAyFTma90FR2P38AMKPUDBOy4ksjzoN4QVSUHxMU904Ou4ROsyeoUfrS4cQvhO4DNGXU4LLig
	JWVLquQyZ8g0nIIrQaJ04KVOUEu0sGqh0S9+cSR8rmqJgXjH/2DjJyjHm1AfFZHcKEhat3tmRsR
	mJNlUapcuyarMX0hdx9tEXj8ZfCYZw1qHmJac5jnbtAQ==
X-Received: by 2002:a05:6a21:2d42:b0:366:19a5:b492 with SMTP id adf61e73a8af0-3943229a6c2mr704286637.5.1770780622980;
        Tue, 10 Feb 2026 19:30:22 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:22 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC v3 05/27] certs: Create blacklist keyring earlier
Date: Wed, 11 Feb 2026 13:29:12 +1000
Message-ID: <20260211032935.2705841-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.2 sec 6.31) requires parsing X.509 certificates upon
device enumeration, which happens in a subsys_initcall().

Parsing X.509 certificates accesses the blacklist keyring:
x509_cert_parse()
  x509_get_sig_params()
    is_hash_blacklisted()
      keyring_search()

So far the keyring is created much later in a device_initcall().  Avoid
a NULL pointer dereference on access to the keyring by creating it one
initcall level earlier than PCI device enumeration, i.e. in an
arch_initcall().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 certs/blacklist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..34185415d451 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -311,7 +311,7 @@ static int restrict_link_for_blacklist(struct key *dest_keyring,
  * Initialise the blacklist
  *
  * The blacklist_init() function is registered as an initcall via
- * device_initcall().  As a result if the blacklist_init() function fails for
+ * arch_initcall().  As a result if the blacklist_init() function fails for
  * any reason the kernel continues to execute.  While cleanly returning -ENODEV
  * could be acceptable for some non-critical kernel parts, if the blacklist
  * keyring fails to load it defeats the certificate/key based deny list for
@@ -356,7 +356,7 @@ static int __init blacklist_init(void)
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
-device_initcall(blacklist_init);
+arch_initcall(blacklist_init);
 
 #ifdef CONFIG_SYSTEM_REVOCATION_LIST
 /*
-- 
2.52.0

