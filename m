Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CD18C03D
	for <linux-cxl@vger.kernel.org>; Sat,  5 Apr 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820527; cv=none; b=ZuBFpuVqMpEnakKskZFi4kaCGirek0ROzFAQdv4EkTzebBVfN/yJ7L9mp1M11SyX7Del9lrngxroZHrjJaO+G4d9mB6N+dCz849vq0+aix8x9GW59Pls5JX3xJFiBp+6fvTa9QUy4T7RZbwCcDYVZbsEJF3el53rjkji/6Jyy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820527; c=relaxed/simple;
	bh=jHD5+DAZY+3plQkqy8z/PJIC+7WjoIdTe9Vwt7TmY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXE0ZN1Xtc53+maK1tQ1UiVBcnzeDlFKLyEU3zvX14aQmX4f9Hw6T/dWBnA2zs0lz8CuJydpgxucEYzvTzInb8wgMNLat4yYWsmVo6BV/5PTWo7snjGRuIB6o7TvGDvbqWfn4pbssp3a2HPReRMok1eESwiU2uclM0iPb2sWIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sq1qKmN5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sq1qKmN5"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso41272026d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 04 Apr 2025 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743820524; x=1744425324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YeznBtZ8u4TGia1mzGvTnb61Iecrwihl8v/8aHcOYI=;
        b=sq1qKmN5YOJPHqZ4jvNgl8BfKoQQSxZLhrKLu5WA3xx8RThvY+n14Gq8mAcJ8NcsY2
         Cswj4edhlJDxRTftQHpi7MEDlQ8VrVl7688PDgAdKHmm+G9p5r6w7rQ975HslkYbtuxY
         lVL+7i6Z3qxUS0v9/zhGrfP9hyQGHplLAKsG54phQrRjgyG1BWOskMuawTmZteNFe9Rz
         9smHsdeUj3zw3QXKs1CqgNFEY67CUFjDwpj6v36dwFO30zROvGnnWb9yx0tmq+7bFEsz
         Vjs/IQHfl494/Nl+LeD3zOoF8SlJ2KhbJAxu1h+XFVsHT0yWsvvoVAugoSPAYT4gEQ0i
         eThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743820524; x=1744425324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YeznBtZ8u4TGia1mzGvTnb61Iecrwihl8v/8aHcOYI=;
        b=jSeFkNmIPoJM0n3SixdGzU7W9Fw8k5dEbzOrOrHZj33WWu8RlUG3UKEyjQugLVkcdD
         FJUyH8UsOwI8HEokf10Bv/hnKJHO44nJD/5U6FNgGFh8B7VjVgWHiU/JRTiXMZM5KwWj
         y5QhiZQYAyWMVjJXBZBcxIg4I8j8dtwB/GAyihcvDtGQb/69TVmhcS1QXwCvmfoIYOIv
         yOpxXvY8DsK36NY+ZYZRRA7pZm+Hz3TTlDsLdqYs0CTCj+2RI9c76RiqApQX6H4PsKRB
         xz7ptNiASaBjPQ/DWfm3f9XYn0F4e9GJxq9QwimfX8T75lLwjDv8fEzJB02MNK+isy0Q
         LoKw==
X-Forwarded-Encrypted: i=1; AJvYcCVWcErbs8eqAGM4I4StsI5p1O7ivTei9AJllso9JqJVMr3Kwdzn0b5YvgowQFbkY8Sya8D/WmHYUoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHp2ONJK41ZLy89FE2tTDAIDpNH8tHeBiHKBBXa/RssgrkbAn
	nm/uClS0VQ24xW9TW+ZjsI1sBsyep0KOKX35+VUqSWzNAncCxbAk6PBsuJExpUU=
X-Gm-Gg: ASbGnctiqfl4dUb0y86IpybZif9VguLp+aL5cwMJnUkco1HvKjufwbsB3sCpta1m/4G
	eaafTw37La4XWNSQsMOIkwso9mNLq2Y3oIct4PfXj5cP/Z9XsgExfMGvkZxgdLByYVj+gIGAAix
	3T5xZkz9Ay0JTwOqUFShiQBtCfMnV/hwFsfwqz3c7I70MzjjIONOOk4TJgPNzYkjHmY+RE9TovW
	JBb5T7SEZcA5F57+ekmR/a8bcJavjbtWby/HueIIQRuC47DHp8S4oAlOtvdk6YA3H9SGyQQWYsX
	wE7iVxL1Ido5MZmFUjqAK4/zjyLM6w67YQUocS7D
X-Google-Smtp-Source: AGHT+IFGBVP3BvIBJ9Dexuubh9wtOH03Pga1EqEaf+7mTsjbwZCmarvITX5eoWkuNhU+NhV/tpF3DA==
X-Received: by 2002:a05:6214:21a6:b0:6ea:d388:dc09 with SMTP id 6a1803df08f44-6f00de70533mr79533606d6.8.1743820523802;
        Fri, 04 Apr 2025 19:35:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:ba7b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc05d3sm28642776d6.9.2025.04.04.19.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 19:35:22 -0700 (PDT)
Date: Fri, 4 Apr 2025 22:35:20 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: [PATCH] cxl region: recalculate interleave pos during region probe
Message-ID: <Z_CW6AIE1zoA80qB@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-5-rrichter@amd.com>

There are at least 3 bugs at this point in the patch series.

1. cxl_calc_interleave_pos should be using cxled->spa_range
2. cxl_calc_interleave_pos should be returning ctx->pos
3. cxl_region_sort_targets still needs to call cxl_calc_interleave_pos

The auto decoder probe proess overwrites the endpoint position
temporarily to record its temporary location in the region target list.
This patch restores the pos recalculation during the sort target process
so that decoder probe order doesn't affect region probe.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 934dcb2daa15..5c9e2b747731 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1879,7 +1879,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	int pos = 0;

 	ctx = (struct cxl_interleave_context) {
-		.hpa_range = &cxled->cxld.hpa_range,
+		.hpa_range = &cxled->spa_range,
 	};

 	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
@@ -1892,7 +1892,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		dev_name(&port->dev), ctx.hpa_range->start, ctx.hpa_range->end,
 		ctx.pos);

-	return pos;
+	return ctx.pos;
 }

 static int cxl_region_sort_targets(struct cxl_region *cxlr)
@@ -1903,6 +1903,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];

+		cxled->pos = cxl_calc_interleave_pos(cxled);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
--
2.47.1
