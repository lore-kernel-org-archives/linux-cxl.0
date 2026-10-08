Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006F44AB9B
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458427; cv=none; b=i6yOLfnFKAkPH+oZLOfWi23tSEK5RxSIrw7WuHJ8UbMdwVEfMtw7OF+ICiMhjjLneBbl03zUUmru7CjM8AIlRggrFvtxWHQT1HFPWaAazX+IVHvwLbGf97H5vYq+Kj+Rnmvv3ir3RNaSSZ4IRpj2MR5FJGA2a6ONjt8LWiO62JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458427; c=relaxed/simple;
	bh=B3VgAzE1fV6NLyqOFguVSmI0qJqk/diBymVTA99Hj50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FPX4odrOKtroz6WUQf3agblgd22OhAJxbktUoEwa7Wj6Ti1Px1qou5I8ibpa9W8nJQuwwhAXrbyWVpgERQEQoa8bMRo5zsJqC3au6o77GvzMmP1kApHBEA6PJJi5jjSHnE8/lzVzlYpDO46kjitZrQQ0TBsnfwH2s0UcUUVAFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6MO1T9+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6MO1T9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791458425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eic19mjHB9HL/L+XEW5Q/d+IffJBXxfVI0tTJopOLKE=;
	b=R6MO1T9+SzuZofvQKllR33daLt1SH1gd0TilQsxtTVTz/R6YS/Pg0EbFw4rUBvZsRSlo65
	zWUbGDbtGUCXBw/h6cJBlvvfgfRSBsvTKJzTTNPi6c3x++jRveNHMX21fczWR9ZHFW/6mf
	HGScet//+JcrI7Rv4kAlxOOi+UDeMC4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-0T-fJ1LjNgK9_Z3lfRwjYQ-1; Thu, 08 Oct 2026 07:20:14 -0400
X-MC-Unique: 0T-fJ1LjNgK9_Z3lfRwjYQ-1
X-Mimecast-MFC-AGG-ID: 0T-fJ1LjNgK9_Z3lfRwjYQ_1791458413
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c210c66672eso233903666b.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Oct 2026 04:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458413; x=1792063213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eic19mjHB9HL/L+XEW5Q/d+IffJBXxfVI0tTJopOLKE=;
        b=PBz2A0Yv67GFoCI4Hn20JUKfs94FtNOUZlpj9Zte1KJ4GXLVIkJNCTpDMQtcUMtK7L
         9EPVgI/xKapmhiBI2KLcful79L7TecKG9CH5Tlj5xlpKuNXtJByqUmUFxXgoX2LOSpb9
         L4oBMQRC8lR+CRfoXtmtV+iH+HeOCJ0N1JY6NO5TKcFIyPmfZ1iW+4TwRPoMs1g1anxv
         UBWIcqd3DruxesTI8zZkMuSc2sl5b71cuBVa7P118iKs1LuZNzmloHcLYf6FXWVcAWep
         F0P1IKq5qi84pNIDsLkqAxaxyaUJ/dFkkrcdGIOl+mzGjcFrulm13tNqhDRb/VMS9oSc
         bZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf/zhPcnd0Uvz1zET5FkOx4htzyTr6LsDGQNYmAFiGBh+trOILsNfSeHkPXukVwRdVF9PlAW04WzY=@vger.kernel.org
X-Gm-Message-State: AFuF++kG9zxSLEqlJdNvK5amTb5PpMMY/UrBCGCeuneSWVlfrwblvBZq
	8JTKysmDi3mbHLXp2ntekT7vPf5OY6PLg7J8tNrKUA+2Nm6bx4EIBEbPlvCw3N4jQy9ld7AAMpl
	EjKa+W6s412FuUnGk9m84VoHJ4QBor1MfiA6y+4Gsp6/ljFzfGtQvreewaHhyQw==
X-Gm-Gg: AYBFou3wOOvi5UZq98xbj0rK4+tfcXdyNOpta6MOWgceAVXBScy89kCwFyXRrIkXeBU
	aiAZrGDXNMxdXTHmiH4KW1LMX+HXqRTUE9ezjHKOdhpmf/hCuqYCMYeU4aC7ZvcJipdPrIsBtt6
	5FYYklD2XNKH++6fmr/JcojDhIkFcjBjCwTpA33vuVCjtKESezkXW0+ag1+PAwNmTCZhW3uoFwN
	jnxQuLjMG7iUtALNzW7gWNAcnE8EZ8VsyAvd8Mbf+A1+1PbZJPspqF0MNZVQLH7qsIe8nt+uhnq
	5ZqHmnxLW1jJifeenw2xunTiJ398tVp55ebqgeDIFYcKfDlFZNXg9ymwcz1LtKUSpMBPSRngqjr
	JgswyX5w8cTXBkvJ3KBirlLjwmA+cXvzi+b//mGaoRiGIZAb9NSToNO+V
X-Received: by 2002:a17:907:1ca2:b0:c2e:969:a4b0 with SMTP id a640c23a62f3a-c317c11a3efmr469399066b.38.1791458413016;
        Thu, 08 Oct 2026 04:20:13 -0700 (PDT)
X-Received: by 2002:a17:907:1ca2:b0:c2e:969:a4b0 with SMTP id a640c23a62f3a-c317c11a3efmr469397066b.38.1791458412617;
        Thu, 08 Oct 2026 04:20:12 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2fae53sm204251866b.49.2026.10.08.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:20:11 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH v4 2/9] dax: use READ_ONCE() in dax_holder()
Date: Thu,  8 Oct 2026 13:19:53 +0200
Message-ID: <20261008112004.1899560-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008112004.1899560-1-mszeredi@redhat.com>
References: <20261008112004.1899560-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AtamFbLg1gzJEB6uavZ6NI10kIM_3yizkooLJ3C8W_Y_1791458413
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A future fuse patch will utilize dax_holder() in RCU context to make sure
that the holder can't be freed by a racing fs_put_dax.

This patch just makes sure that dax_holder() works properly in such a
context by adding READ_ONCE() (equivalent to rcu_dereference minus sanity
checks).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 25836f389bde..76e8d3654629 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -642,7 +642,7 @@ EXPORT_SYMBOL_GPL(put_dax);
  */
 void *dax_holder(struct dax_device *dax_dev)
 {
-	return dax_dev->holder_data;
+	return READ_ONCE(dax_dev->holder_data);
 }
 EXPORT_SYMBOL_GPL(dax_holder);
 
-- 
2.54.0

