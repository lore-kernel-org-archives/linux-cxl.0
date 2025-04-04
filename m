Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1141F542E
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781015; cv=none; b=jNkKGSaCdVMmAfNCmw5bnSHsJO+Gka+ij6VatC9v3Smm4MhHZGfZDqh4rvCgAXNgYvTmczYyTgD4HS8UEuzVR+Grug8squJEDDwPFXXBjCCbYJ9sH63UPgxuMBpnIFWLrZ5SziCxvn28couLxrGM+/Ux1ul2PGKp46NmSwxST40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781015; c=relaxed/simple;
	bh=g+0h4aQ5Z70IQPz+rQ/77kw7q+wdFaAD9l7dNG9FGbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP0Rl3r629jAp2ObeHhWpsu0wM3N9shYCv/FPIQttzCp+W/ICJPRh9zugXj9EKdJ19J8dpav8SxzlE5CZwg08nSJAeMTEIeWJKdwKJupbbt9VHdpjzBKgglCGHmtqPgggWTiW42F/MIc6nMdd/7WSubDPhF69Lc2WNA6y/F+seE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XW0si7me; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XW0si7me"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e904f53151so18516136d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 04 Apr 2025 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743781012; x=1744385812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B43g9c/o/rHrH7JhcXRPYa2+wmwxTP1Eq/J3fv7ix5U=;
        b=XW0si7medXYMH1akXerlW+mAmFPq58TS6+AvvXR1ls++jbvBFHIlAawhVHOal22VTD
         WvcBmnReOZfN6EOGQLmlrZ/MoSYuiN/1UszsFhDHtv3pLMNq5ZkYIvptOKZiqJ9szZXl
         BzLCvhkqj64PS/NoW/9jxMoviD/WYmrOHNA0LILvDylzangvBjKdxm2XEWLj1VQD/wbT
         FywYuB21hGPcAy82DNL8rdfFdBJwxjml7rKYWT381XmosA3D1kxJOEEXyUi0VPJ0Y1hU
         fKDgsJHMuyqJjrI3Q+KsAJON1Z3txkdhoYR2IO1Goo2zxU4CvQ3gTeCPscA1JjlXu1rb
         xFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743781012; x=1744385812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B43g9c/o/rHrH7JhcXRPYa2+wmwxTP1Eq/J3fv7ix5U=;
        b=qRjUbR2QPjqSAyc+sKxRoaMfYm6qN/lx7T2r3HWXsWBLo4e6yrTJwoUfceHdihZ0BX
         IRBPYzezTO786z0YrJJcSqKxe9UutkIRpgzR7aE3xTTgAGkwQ3c/FSq1eeo6yS240QZT
         39EloFNjJQ8t2UUouc4gtoYdQNoM1cjEwkfuyYTMn3vZBz0u2we+y3Gru32Q+i4zPbiq
         d1q1gEpJWwMMlqlMCadvQEf49P8nwTT+wmAcG+k4+cXvT4HEQQXexx8n7q5Ttvdhqc7I
         bbZFOgUdpuw6WoEznWEz7R2byhBdeuMP2sstuTV8Mg+ZFGddjOuDK9RZwnLKWJ5/v+pB
         hutw==
X-Forwarded-Encrypted: i=1; AJvYcCUe6UKoiOEF+bYTq6g6BMuqU/LOZ8MO0OU6CZVuHIhXeMbfi5SQp3QY8gtg0oI/GNjHXow9/sFYxtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxEvZ0DYdWr2SCLRJ5jT0yPNYhRcrGVOc16M5ndjD4qc/kuaO
	yl+gGmZMv0dW8241GyA4cMYDnOsmWG4ot3jvu8fM1VJCYOysjNWhp+pMumtjunk=
X-Gm-Gg: ASbGncspDnmZHMnAbRhnsXEInTR07uKT2o8i7NX/KxvgcCVvD2kOmtohO/qbZAIvuSe
	/h7zJJ/MIvKLJkidSFnwXepL58mojioiufnAzncmtd58jFBEi6HGZU1o1/kOM8lWYQWzScVdcK0
	sAKULqCQTWQ8u81ijl6134Qu0MOPuH2kZZEArKHqCRWNvTrCMQ9SgfVF9o3tHv6DPKEQ34xhCMu
	bpnDVUYZ2qHWk1JDz+WKe5ZnQfNIijjJXgCmcOhyNCw104y/KejOViKfgkaOgCAEWFyKKi6UCb8
	dl36XpB1OKlSsE4gxD5mQEigSRL8m/bb4woyKZSAIg==
X-Google-Smtp-Source: AGHT+IHzsl/rGB5TpApac3V8REUo608kA5vX5R7bGjjtuDduI5bJPlPMS8A6Ptby0Z2FAVJ2aWmSPQ==
X-Received: by 2002:a05:6214:f08:b0:6eb:26ed:4d87 with SMTP id 6a1803df08f44-6f064aef3abmr49700076d6.31.1743781011733;
        Fri, 04 Apr 2025 08:36:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::6:e00b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f047c9asm22850266d6.59.2025.04.04.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 08:36:51 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:36:49 -0500
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
Subject: [PATCH] cxl/region: Continue recalculating position during sort
Message-ID: <Z-_8kRHep5LVeuvS@gourry-fedora-PF4VCD3F>
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

The auto decoder probe proess overwrites the endpoint position
temporarily to record its temporary location in the region target list.
This patch restores the pos recalculation during the sort target process
so that decoder probe order doesn't affect region probe.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e1ef0d577b35..8c79c0a39d56 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2061,6 +2061,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
        for (i = 0; i < p->nr_targets; i++) {
                struct cxl_endpoint_decoder *cxled = p->targets[i];

+               cxled->pos = cxl_calc_interleave_pos(cxled);
                /*
                 * Record that sorting failed, but still continue to calc
                 * cxled->pos so that follow-on code paths can reliably
--
2.47.1
