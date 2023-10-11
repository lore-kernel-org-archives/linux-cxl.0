Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6F200D7
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zo73HEZz"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20888D3
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:04:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d885e97e2so499394f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697033093; x=1697637893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5OfWY4twS7H4/aYG10R5WxzZhGF9E/3P2iJ/+V+fOY=;
        b=zo73HEZz0TKSWIyU+5H6iifVR3wzcNCyi34qGjJ7jE8Shsd/7GvYRFiAL97thWIsg1
         eEXu5pMq37/zT3O3AXpD9/GtW4KBsvCyGPDJDlJApckf5RIWeScqCav7MksshwPxt4+u
         0zLJha95BgFsSTHnvNdFCkzA+44o8+9rfl2+Xj6AHHOWNAhcm98dMTTl/HwoDQXoX/Pq
         qGXXI+BNQyh64XYZtmOst7BAPQMaSTlXxyyUxtqnm33rH3PDu5l7+f/Pbu40OG9VtWKq
         Vq5V15ZBAOYAW5lnPi5y2xkhVqSsNgVgD5yeFLDTuWcb2TrnZlcyX3z8J0jrhsNARtBS
         csPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033093; x=1697637893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5OfWY4twS7H4/aYG10R5WxzZhGF9E/3P2iJ/+V+fOY=;
        b=schZxeQSipM5L8Sg5TZPJsq9qVrpL8perteiI3xf/GZy4RftJZ00EQFvQA26y1Y2M/
         Q7mTVq663tBg1OaOr8VMAcDE6Earx1XKaTjyy8MpLHPNmXk9GonZYsog4QSxAJV7W0rw
         8ddTmUhU6izHJqoAnhNYIbuEeOh92/tSGUpD8HgsrdiBv0Wk5vJgRC/+gpj7hcIKNnfU
         B19s7aut5LfGw9HQYF1ef+2mUUHc2R/5gjkFrFH/z9Pc4arv9xejwBQnhMwqjLLIJspG
         gqMjRyp5qNJkFhRmaCBQTgXyDB9g9PB8STxFtEbsCIu3HyI+6B8mCFg/ya/bf1Uz1cMz
         pL/w==
X-Gm-Message-State: AOJu0YxkKCP4hl9OVi4qYV/HcqU/u/NvrdXWyEF7lvKdReYnMmlth/Y1
	Rj1AcNxvvGCxiMEuuGwKz/sQLynNiwTxrKS+Kiw=
X-Google-Smtp-Source: AGHT+IFiALPpD3wA+I5n7yJAWHl96t41Axk2CqS+xJE87wJilcT+JVb+VW1HvxOVp7S8I2ORhY19kg==
X-Received: by 2002:a5d:5110:0:b0:32d:82f7:e76 with SMTP id s16-20020a5d5110000000b0032d82f70e76mr1903397wrt.34.1697033093137;
        Wed, 11 Oct 2023 07:04:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t25-20020adfa2d9000000b0032d8373fbe4sm2274289wra.51.2023.10.11.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:04:52 -0700 (PDT)
Date: Wed, 11 Oct 2023 17:04:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jim Harris <jim.harris@samsung.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Message-ID: <f3b613eb-b948-498d-bdda-9038c7cf595c@kadam.mountain>
References: <CGME20231010183840uscas1p294532ae60e6014508efd897fef14fffd@uscas1p2.samsung.com>
 <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 06:38:39PM +0000, Jim Harris wrote:
> Patch 5e42bcbc ("cxl/region: decrement ->nr_targets on error in
> cxl_region_attach()") tried to avoid 'eiw' initialization errors when
> ->nr_targets exceeded 16, by just decrementing ->nr_targets when
> cxl_region_setup_targets() failed.

I mean that's what I wrote but I fairly sure that I was concerned about
->nr_targets getting incremented to an invalid value.

drivers/cxl/core/region.c
  1746          p->targets[pos] = cxled;
                ^^^^^^^^^^^^^^^
This array has CXL_DECODER_MAX_INTERLEAVE (16) elements.

  1747          cxled->pos = pos;
  1748          p->nr_targets++;
  1749  
  1750          if (p->nr_targets == p->interleave_ways) {
                                     ^^^^^^^^^^^^^^^^^^
This is how many we want, but it's capped at 16 so we don't go over.
Like I guess we add one at a time until we hit the max and then when we
get everything added

  1751                  rc = cxl_region_setup_targets(cxlr);

Then we register stuff.

So if we decrement and try to attach another region then my idea was
that it would write over the last element in the array.  But if we don't
have the decrement and we try to attach another region it will go beyond
the end of the array.

  1752                  if (rc)
  1753                          goto err_decrement;
  1754                  p->state = CXL_CONFIG_ACTIVE;
  1755          }
  1756  
  1757          cxled->cxld.interleave_ways = p->interleave_ways;
  1758          cxled->cxld.interleave_granularity = p->interleave_granularity;
  1759          cxled->cxld.hpa_range = (struct range) {
  1760                  .start = p->res->start,
  1761                  .end = p->res->end,
  1762          };
  1763  
  1764          return 0;
  1765  
  1766  err_decrement:
  1767          p->nr_targets--;
  1768          cxled->pos = -1;
  1769          p->targets[pos] = NULL;
  1770          return rc;
  1771  }

But I was just going from static analysis and code review and not
testing and obviously you have tested this.  A simple fix for my
concern would be to do this:

regards,
dan carpenter

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d63b8798c29..5948c4a01745 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1649,6 +1649,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENODEV;
 	}
 
+	if (p->nr_targets >= p->interleave_ways) {
+		dev_dbg(&cxlr->dev, "%s too many regions\n", dev_name(&cxled->cxld.dev));
+		return -EINVAL;
+	}
+
 	/* all full of members, or interleave config not established? */
 	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "region already active\n");
