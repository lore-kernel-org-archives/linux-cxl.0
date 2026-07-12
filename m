Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAB342510
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871131; cv=none; b=dSq5ivQixFySKJKcTXgntuRlDTfhIxjNtGAzS8ApWgCS/xAwSoJxVNFZw+wy5O2cER5FtrMRYGbUAs2zNnM0Yl7BeuQxyqAkFtDFFPo3QnDjTO58gdKZDLf0PaRqKpzpJ6DwGSDV6rOeyTDhcBmxzFbSV4fI466aor/tWwIeBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871131; c=relaxed/simple;
	bh=JQAGfqE0PffesD9sKQCzYKMipVFSPTwh6dBNXQMkTdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0Ah2FBLKP9jlNC2HzyV1R9fk+IPrhPpo5TxWwVgt9aHDufMR/TKZUEFCgwWSFucvJmmBg47q5/XwB9IUMyzwqeOd1gXc3NFopzWkoyHZ4/4TTQpO/nULgIjh34HwYrLLimD54NIG7pZpFcmH5UnLxdMt+AmiNseARtK1NrgNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FoUENce0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FoUENce0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e512a9a6bso112855985a.2
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783871128; x=1784475928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BguinuoorksxpsezVhTMBAsbvTRcZT92EAAvPgOWJAM=;
        b=FoUENce01JxYTluhLc5Y7qWU6Bow1Kaez1AeUpF4WAYoDJEI8anyrVCnOoZcX54xly
         /OpZn4309Edh6qvdQnG86scRqFn5z32sdULz3ce8ufWYgAQjNfBKEBWr7YKL53Orj0Td
         x4yieCRsqVgCIPXOzs/+E590i6XSdjooMpw2Ot+BmM51Z0Oh+SRs8n6D2FHpL0fTm6SX
         McKloS72wuX/qKbCMW5R7ZqwgqfLTeUZOc7LOSiHWmE3iYX6nqijsIQeoW6+0exIE3cZ
         2cDDOLteKNEqM3oEVPa8tvJxnwGCNnyFF/0F8CHAKEayG1woayG8tm+wxjYkKEX3skI4
         Lgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871128; x=1784475928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BguinuoorksxpsezVhTMBAsbvTRcZT92EAAvPgOWJAM=;
        b=kYqdptUCeaA5SL+YERRqgYUgzDDXtc6R+OJd2FwT6m5lTrPqS/K0TazOruG2AnbLOd
         17iLCgYsm4kfE1LtKA4ul2kvdQrfjAdCM0R9UseEcIbJgzrksr8ebAPCh4KdqB1fk3wZ
         cnBCAiDu9cncWBGpAq0qkLmLZPuh6uq5jEMocf2wFdPwkZMentvygqh3K3CgcJ16aMji
         zZWYmSO801vOf27XiTu31OCIr0wCtP7fB6r0KwQthTIBRCaW5n2FeeMz+NBEpXVRRUMX
         1JGC4WnVoKa8q3arYs/enI9/GVF+lkxtMD6S3GEbb8et+RCkNf5z8wKIEtIDXznY9Rql
         FJiw==
X-Forwarded-Encrypted: i=1; AHgh+RqgRL/guwnZ+WaRlxqZ5HeGLYhcjfGc8jzq5pprhUMHF14LWRdXqP7BF7dmZ4641kli+sBq1umGh18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ds2bQOYSuSf6oxGnIiQOXxj3lYDY8r+j6U/giHnkyhq0nerb
	ZBCXeDxhojUF3vWERWgRt63UDn/7wnZH2T8bzoHgh7CtQoBWCZz2QLqXCOumtjZn+pflsovjk0B
	WAfvn
X-Gm-Gg: AfdE7cns0bGAjQh40GPiNl9rn+OqLRuxX/Ejff5pVfkClXW2/sFeGB0F7M/VVaBMiUk
	67Tq/glWmjSr1MXpQ2K8L4V4NqwZqy6NJBU4ngvqHTxhif799gKyy9q049BpFJpmvkFevwj4+mP
	JrPwWBtjcpy5NNvqnt5QJ1ML+1OaBHUZfYhtAJdfP17sq3RxkN1JNfeExOp5rnA4+2N6DrPURjV
	c/XEth/t5cU+FuN02Wxjrxn/jRJfEzBU5N7fDQbhk5D2loDCv9BpRXGyOkGXpF97nXSl6/sbxgo
	L2WPfTws2x4nIS3uCaAHNmc1HMqcHaCllfGkM4KFxnebc10D5Mf47u/1bN8slJOCx/GJ99oSvym
	8VqqFuOI/5zYWjjyRpkvlbANz/yJMVq8Mzm84+ePFeH+0Zd6aR/w1B77y89lq2XjYNMrHRTcG+A
	qfvkIc4m1Eg9lV50lPjeZ03cNE/KRc7hY6bC3AiHZeONyZ7a8C+vfnWaVz6/U5/lYUe64qCpQkR
	CZSl95Mm/em
X-Received: by 2002:a05:620a:400b:b0:92e:c117:5ed3 with SMTP id af79cd13be357-92ef2e222a1mr610227085a.83.1783871127659;
        Sun, 12 Jul 2026 08:45:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm862186485a.42.2026.07.12.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:45:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net
Subject: [PATCH v7 07/10] dax/kmem: resolve default online type at probe time
Date: Sun, 12 Jul 2026 11:45:01 -0400
Message-ID: <20260712154505.3564379-8-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712154505.3564379-1-gourry@gourry.net>
References: <20260712154505.3564379-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the default online type in kmem at probe time explicitly
instead of implicitly inheriting the system default by calling
add_memory_driver_managed().

No behavioral change at this point (still system default).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 592171ec10f49..38ed5c4e9c83d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -73,6 +73,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	mhp_t mhp_flags;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	int online_type = mhp_get_default_online_type();
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -172,8 +173,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+		rc = __add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, mhp_flags,
+				online_type);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
-- 
2.53.0-Meta

