Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078793;
	b=V8KYRfIpiZUVY3RUdUyih5yPzcVR0rZn4JK/3tvYCiwrA9mfw0PG4rXgNqwXY1Lh1VkD
	 sFdTwvbWZEdtVILfLG5oNaYZkCBKMkBwYCOJb1AlLkemjPaH6HzC8IYkdppe6NVERkk7a
	 YQMk4rmP9kGP7Tmk1SC1o2MtMCbcAKgMjsgXFE0J6v3kVm4SRcWxdH6gSp/hUCjr4xX18
	 /FGc0pq+tVHxQNcl9OHsHVrYPEsbGrxC4dG9m+HJTK1ASTwF+cX8fMfFvdeY+H+ocJ41s
	 OdWUlZnh4bACcWdgUaFzbQ4V03vgLCTF193cKbRVALV9QK8te2b8s0k0opxPCHWhk1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
	b=aoRY+I4ulMWa4jXmzPI65Lz+b8J3ZWGeS93OUkDD597Y9pyY6vrtHi/mdswb3FIX07Fl
	 rP1IV7BrgiIL/iK2K5DECX05i/FYlFBu3rjV8lcpAnTcxZBc3kh3qahkTSLu+9OIVX9cE
	 arB0AI3OJhIo8RK3s3BjhEu81Hg+KkYirhKAITRFsuHKkUj9i112pt7GndWiYV9feDCSE
	 PdihOW+XnboTdxIYZeeM1ZwqkxWlB8a05CckG0dQ8Tf7k2Cuzl1HmIdl1VpHKxfL2iA5s
	 8zregiRLjEECXNCp3HAyOBSSbkCb05kuiywdZRK5g+loUUOUvNUDKI3n+PCK4k/aOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrICPA59;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A43606A324
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A43606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrICPA59
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea1e7fad99so19468805ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078792; x=1793683592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
        b=JrICPA59gqLNarvkqoO6weEHrW/zx/EtXlFr41nnZZhTOrquJH+7KlJpdvFvK/0UcH
         Dh5tNFTgPHYmXFKvUFewJIi2XvEK8rLKITKXSbOkrM3tI+SRkVR5oEMTKMAZb+VhmfnA
         rluifilPnZR2HrA4S8rDrLOLFcEIqm24Mc/Mp67k+86FnLlq+Pxfhy0Ov5ayl9ME4LYi
         RxR/iKU2aFqvtDs2/s42VfPtOGh0zFNvFu7m57mUq/IEpvdZT6da1uFfplL4oOx2MdkI
         ip7NjXTlg7qYq5uigXCZ+bFxBy6qDV3BeFpncVkIDluMNLte1MR4h3C8r3vHc0TileXf
         1xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078792; x=1793683592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
        b=ZPUhU1dAAJSrOO7Qak/y6KHKJHXcfFSSP8hGIqNaW/0qpGKZKYm0BZ1MgdhvYWAF3p
         M5hAGSessxMc6wO4aueqUQREJIOrR3jrBRTZ5yIxOZ2evjPpOZjsVFX21Fm5ZE+g34ih
         Bnk60CpNFimBw4pwLINuNZsvvc3Sfo/FBYjJo05n+mmjZybLkOpkNrHU0LBroyB4ZHA7
         1MgDPrRoedLZsqgX3cH8P532JT/Azo0J0aexNqm5F5EWK3HzPNS8LdKKW9gCakY9tcgV
         lyb6UlEEEEc5/Fm4hIWSjZrlXfFXaUGJ1aA242gy0YoliX0EZSIYLcfYNcTZp8/0QLg3
         ZA3A==
X-Forwarded-Encrypted: i=1; AKwUvBx7G+glfhbSET63hrA1zeOBQJaOGqe1UKRbgDghPp/lskFgN93Znn4MaFj5oAOV3SWvmAaZtIfODUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7V62Sb82pesu+Oc8wmC7y1ZSYTjiPttnQJwoW04NlSoYnCMZX
	/L7bwgbWEbPXa9mz0qie+4/R24j9LDY3xJR5AP3vE+EDOuoM1ycYyC2l
X-Gm-Gg: AYBFou2zA2ac297wJKpdN459FW9rwzovdV4e3xKX9EDrv2Na+G20pcOhIkFvCvy6lG0
	ZEApJYcIWwlt8lgF2iJxZ2UUw27+X6kCR5Skn9zdwYoVtiHiShZD29s6ZJCqgXXJqHfBCgZvHfM
	udaL/qRJ5BwnauoSPrmAM4BFi6TZIj8gUuPKQKOsNySajB3J5+6EADQ3CdKlwU/w9xe3BW2kJdr
	i6PR8GbE9FD4fvH9s8Ae7rdIJfKdFoMEBFnzCQki3W/F/pFfREByIyQTPVX71MSvo89C/6gKHap
	sVT2i9uyuMdcnf+WVzaaDVYkMW90ffV3rv+QvgUimziSHOHPFC3kkLWW2O55dczGpNY8OFWrfXa
	GxS+L9024Ew3lyq3mMggtL7QOo/knvwuoNZAM9USnuQWPME14e1LWPkWEELTQTNKOP64oRml1GE
	munORXmLfO4uVxp0D+LKApjAlm1o9GHYyUciWJlquhwoVUve6BtUOceFUJrwQg1mJH8pY1nryR1
	9OgpqAnbWEro23BeKBH+t7j+xv5e29JgkZmgxUgHULZLrv/KHD+b49DbKd9z8M0Zs9GlizChw==
X-Received: by 2002:a17:902:dac4:b0:2df:b250:ad9a with SMTP id d9443c01a7336-2ea9c7c46e7mr64891145ad.48.1793078791992;
        Mon, 26 Oct 2026 22:26:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 06/23] X.509: Move certificate length retrieval into new helper
Date: Tue, 27 Oct 2026 15:25:19 +1000
Message-ID: <20261027052536.1722081-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26a..174451b93edad 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 ||
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 ||
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 1b91c8f98688d..301efa952e263 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.56.0

