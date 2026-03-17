Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF053BD24D
	for <linux-cxl@vger.kernel.org>; Tue, 17 Mar 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749633; cv=none; b=ff4n+31W0oBDPX4/tun3IpKlI6uC5bU0J9Wtpci99ZgS4BHXorTt7tG6vSxawqwilpzoMnwvoew7/zTR95mZwLlGwZwhj2WbJSbgjcmXXi+ZJXE92K013OM7JwJY0Vk/JMu1FwkurFHbfIscJkN0Okqnsaxq3S1uZTf1NOA1zpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749633; c=relaxed/simple;
	bh=Va2qM/cimpsje9gFOY8O4nXMbR3NA1ZQhqbLAPAMZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PtZjy5Rmbqyp7Xen4vzE/xn9NDlcOKrNgBLm9BRnhXaAzAfX5Pll7ZgBAYOWUGad5QzrY2y8JwteU0ZR4WQ/JI79wp3QAlJoDyC+avSo6FYC+SGk9RQ0B5bmS2r0rWl/4/VsDAgAG5+YUHasVOONODlkcazQe8wfZK81LXhiSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2vKrxmb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2vKrxmb"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso2202848a12.2
        for <linux-cxl@vger.kernel.org>; Tue, 17 Mar 2026 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773749631; x=1774354431; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAvpnBM9mSCqOK83LyVDKz5ibScu+cS1rAPnblJhlu4=;
        b=T2vKrxmbYJiZXOQgHfxQvkxpo+3jn+vK8EEUDpcKudRcGY2mSDmwZS6F+NVE1eQq/1
         fGVCFsQS0bC2UEnLE7DimbLTFjNYdE3MM/9JZADRKxckq2doMVDf2kasm2tO5Zyq2rBl
         YzZ3FAHUQpHd3gvLBwEtB1Xs7GbghmyZc3L7DLLuNSyk+Tv62W46bAw7leCgJENizjAI
         tFgKWFazbF3fftSqtyQMTJDGXDpT6iGAqwMPtbIegXhZ2l03Wmi66G/K+idwginGhove
         2cAQgdLt6j0vVVWroZBZM2iyr6SYU/9gWoYSfpGMVB/mrMR+0MK7M1mQd4NC4qCsLy5V
         5Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773749631; x=1774354431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAvpnBM9mSCqOK83LyVDKz5ibScu+cS1rAPnblJhlu4=;
        b=PV9xMpoqThcUM/MlZhhI+p5+yL0kTPuXQC6T58R8li4+W60rB0BbF3kvycS0xlr0FX
         rFj8hLUSh2wiHU7ljUus2BQwtkRUc52hbA5UMz2qMVK0/FpMzT1CeBqRGjCG6dHSW3Tg
         w2G7Zy5c7Usgsils7v2FyEuhfjNFb1+8Lfng5UVE/onuSLgHqG7Yyo5eR9ryRKM+OHim
         fNH0gzta80B1V4jJN7JF7elXe+IQ8BvsQJgOGeZKiql+RRq/Ng5LOdaF79EhxHypBMwU
         TMWVioyYkCcH8TsCGKwxprwwt+LnR8Df2TQNQjHnSjV9cb6vvPVZHWYK55yENhuahzx1
         g60w==
X-Forwarded-Encrypted: i=1; AJvYcCWVmVSSGEF0PoKzoIGkaaoC2V58PfkPzt3pB6vnIjBXgH2y62UksFK3U/hG59BMZeLrxEucz2p0gLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYtcYPbsi7vlW3nD8gshkZkuZmi8B0K9C0hecfquhTiVuEe2u
	ZquEiKn/DLJ1bOgwdNbifLiXOiRvAGFS8whUWbcdz6t05oxOQAeRWGcKVjoebEIZy5s=
X-Gm-Gg: ATEYQzxuf4gpfSCHendZrHnuyNi2CZz/cmbvGgCHPmaxfdSiY3cCIYkCMRoOvc2qCUx
	aqy37dy/H5AV9GDHN+ND1guQ5c5zOI4697gsGsEdpwZ+NH12BoYvKNrJrQKQQAm141VnO0mU1L0
	sx7MibGnh45v3e84gWFd4Vhq4JeuNDDYT3hXcEjqfsCu2fvxbk4o3U/uBjboc+jk+Tg7nbq8Jj4
	XmXRiXATpUHRQ5Nht8ralCR1qzIL7MHcdT/MQN04wSmV5qFIGfoJAJM2Rxyl5ldxuJ2DE0v4typ
	+WC6a2wWIOBMioW98n0/PGU6uGnDDCaIlNyESFZFmUEwuaojD8sNo1ZdqnYNdB3vQbkSnF/10Ze
	YKLxAo01eaZwc464IJnR7Z+nqa8mmUM+dgMqeVprz9UA8iUV204RtiQpaRy6ib4mU3fzicpuLzX
	aV5RsLiArAJygxImVgk2TOFY/GOaDb9r5FXhw=
X-Received: by 2002:a17:90b:134d:b0:359:8e5e:43de with SMTP id 98e67ed59e1d1-35a21fed329mr12751806a91.22.1773749631501;
        Tue, 17 Mar 2026 05:13:51 -0700 (PDT)
Received: from the-machine ([175.157.52.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcb8b9sm3840148a91.13.2026.03.17.05.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:13:51 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:43:41 +0530
From: Teshan Kannangara <tpk.teshan@gmail.com>
To: dave@stgolabs.net
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/acpi: Fix coding style issues in acpi.c
Message-ID: <ablFdTrypTz67N0D@the-machine>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix various coding style issues in drivers/cxl/acpi.c, including
indentation, line wrapping, macro alignment, cast formatting,
and conditional braces.

No functional changes.

Signed-off-by: Teshan Kannangara <tpk.teshan@gmail.com>
---
 drivers/cxl/acpi.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..b54b962cf973 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -395,9 +395,16 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
 	cxlrd->cache_size = cache_size;
 }
 
-DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
-	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
-DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
+DEFINE_FREE
+(put_cxlrd, struct cxl_root_decoder *,
+if (!IS_ERR_OR_NULL(_T))
+	put_device(&_T->cxlsd.cxld.dev))
+
+DEFINE_FREE
+(del_cxl_resource, struct resource *,
+if (_T)
+	del_cxl_resource(_T))
+
 static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			     struct cxl_cfmws_context *ctx)
 {
@@ -419,8 +426,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		return rc;
 
-	struct resource *res __free(del_cxl_resource) = alloc_cxl_resource(
-		cfmws->base_hpa, cfmws->window_size, ctx->id++);
+	struct resource *res __free(del_cxl_resource) =
+		alloc_cxl_resource(cfmws->base_hpa, cfmws->window_size, ctx->id++);
 	if (!res)
 		return -ENOMEM;
 
@@ -542,7 +549,7 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	chbs = (struct acpi_cedt_chbs *) header;
+	chbs = (struct acpi_cedt_chbs *)header;
 
 	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
 	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11)
@@ -774,12 +781,12 @@ static void cxl_acpi_lock_reset_class(void *dev)
 
 static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
 {
-	priv->desc = (unsigned long) pub;
+	priv->desc = (unsigned long)pub;
 }
 
 static struct resource *cxl_get_public_resource(struct resource *priv)
 {
-	return (struct resource *) priv->desc;
+	return (struct resource *)(priv->desc);
 }
 
 static void remove_cxl_resources(void *data)
@@ -850,8 +857,9 @@ static int add_cxl_resources(struct resource *cxl_res)
 				remove_resource(next);
 				del_cxl_resource(next);
 				next = _next;
-			} else
+			} else {
 				next->start = new->end + 1;
+			}
 		}
 	}
 	return 0;
-- 
2.53.0

