Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492B3806CA
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224696; cv=none; b=qWS78sKw7FTrkQAkBL3HiWMr1xyvLX19bQQieN5rirJ9GyjCvKajbxViZ2LaARPZA5GzkhfehEA787S5Wxb/0JgPzrkyxdI7E6K08cgp5z2RbaudRX7KCbIi9Tu9w1WfRlwb7cuJ98m84dzkBZRRCs3A1ycUdvnFj1AAoABqqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224696; c=relaxed/simple;
	bh=ka5L0T+crJoJEiz3RZq9V1G0Q0j+3Njce27Rj8beaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUDgSu4Ypgy1av/Wg3do4/8LqCOUGD8i0yH2sR6lSI2BmUnpjVX/tXmQACsuj2nqUURMDR0nISLDexPPSpZECI5cfB3yNqdctV0dzcamXIO5JUTuA/XejosZtOmqDtJ9qWguJqEsYC7E8l+JR/4gWFLlcTTCdqupkH7A0zj4vB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSDXPpIb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSDXPpIb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d560775ca2so30009725ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224694; x=1788829494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGgjKe37C8O7WXzR8vYD3Gt2KMUFwTc1B/YEqcfdSWU=;
        b=VSDXPpIba2vhR58Bk/6sSHrhsDqP1auIwvd+H2yJtUgp+d9Vcj+K8JO/wH6S6+NGEr
         7tQA4rLyIaJq/SczBG2IRifn/ObFimuicaKwhRCvhhkX1grDqR1G+qNMNro5pJ/3MTww
         Hr9i7na9ZEVcqzxi0AaHSUkPmljYC6FfjC6ONmq3lxrOfvQlwQa9/f514ja3qP4/Rryv
         /wFuOOuLTI2RJXZrIFUeEdvOS38vE/NLGtgQqoHNEdBNkgAA4TUDWvkubPaus7TPWseg
         Foaub8i9ed+WjE7iP4l96Sv3FICwxpfkosDiGEoiObRUxl1n4DVQ0l9LjKMAP1Ay+CND
         8vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224694; x=1788829494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGgjKe37C8O7WXzR8vYD3Gt2KMUFwTc1B/YEqcfdSWU=;
        b=WXMyAy/gyKqPFQoQu8O/gUS67eHFuYYs/zfim8JrtE44qCFVSIlJ5UP2VkFZJfo/UW
         fsslP2I2JBnT4L1724UdLYGovndM8swWa4xmzG5rgBPzwNj3Txu1C7l0RWHmEludDHVG
         2Uz7SxTWGId5VgPmoA0YOm4T+lhuM4VDJFo25T79J1I8xzHsDXZS1EsLzqMLCSPC0cMT
         yBg2j5uNcqYUsdjhW3pnnL6unOueM8JLSwLyTYp/vJtxvT/P47Apc/ACUMA8RdFbhXPd
         xhs1iIc3mqBoJfnJOfz9BMVbBlFs0ra2IFJNaxZ8LL6daIHkxfNTCyE3j7SHfFuS0jju
         u50g==
X-Forwarded-Encrypted: i=1; AKwUvBzKkt73o4FbcfSyjsNy3r0jXLVHOPJvcSUD0t1HoRaRbAvRFGJg8IGSkYqZT4VxNDLaU9TcQb2SSu4=@vger.kernel.org
X-Gm-Message-State: AFuF++m7Ga/4lB/QKzliWKSO2yviaNZsAKc/4X7W3K2yO6qdhrS9uwiE
	kiBtiIuYs5aDJbK/I+fP26dlgBtjVqxEBKewuQKFWJCl8iDdnCgBwNZ5
X-Gm-Gg: AYBFou3bNpD8qCDAYkwc21lz3tGnagHrAkV7S1K9KroKi3vGYA4sPv+OAFIrSUdGtXG
	XKZtRWIkcPGpV8i0cdSsxn3cJwUeFtKHTu9YXrDxjhcaxLU3EgUNlK7jk9OGJMcN3XsAUa508Uk
	2P4vO2wpd22iiyRDUCBI5UCL4/yyWigpweNNuHpBWJGajiK2dxIsmUyiMbzt21bWXxfeT3S6Qdy
	pa3dOCgoMCaZu6MG4VMjb5ZtRFyPGNAmatTJ14nVzD4OwopHC32uk0lPO9wuWlMMuWR8bNpEDgz
	bM4XFlGiaL1Veazoc1IRy+re97zngAAxUETpuXO8BgoxWLbiWaDhCELvXimH5q8JLhsTxbh7O2E
	ahOZMvKoppufY1raXllGxSlHGeovwC+sXXyeIqk/ewiVAEVYaLfkyBhZjy3NceCVBG6Oo2eRJUD
	QXnwEcVQE4tgWbKj5YhCwHvkDhoGS5lPEK6SJQ7NyuHf7uclCQSEhGUixtD+pkv/9+Hckrvyocc
	AUTqiW2crFdEEbb
X-Received: by 2002:a17:90b:538e:b0:398:e436:384 with SMTP id 98e67ed59e1d1-398e436066bmr15200914a91.1.1788224693739;
        Mon, 31 Aug 2026 18:04:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:53 -0700 (PDT)
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
	aliceryhl@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 06/21] X.509: Move certificate length retrieval into new helper
Date: Tue,  1 Sep 2026 11:03:32 +1000
Message-ID: <20260901010347.2614656-7-alistair.francis@wdc.com>
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
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26..174451b93eda 100644
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
index 1b91c8f98688..301efa952e26 100644
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
2.55.0

