Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA66380
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454490; cv=none; b=C0eTZ26vz9ivMKVDaJR/hjQKlO6MHam23/auj3VNUpBeWibsiwt6X7wYYaPSe23He3zxyZ6LzPypTyPVCRsQKdp7kuC4TFdJrkmsNCYtbw2uItFdPp8Kl6aEvtTzUwieSp0gNGvk7hVVd/3/te9l6mihdmwphxoRNJNcHAUJ2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454490; c=relaxed/simple;
	bh=OFSnTDstLNCA40+74rLNXib5Y+YQDqR9VC7j5XzjQQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blok/+3bESkhakzBhcgMOyw/jtmXnEoyg1SduNt3GvNGO+yNbXxyxkuFjgJyhg0uZfzqjW7Dr3PWuYdbeD7NpK5I+AxBJszOe9iOY85ksdUw+v/HL0GFM/8EO1nSKzn2q8t0HjndiZ7fJHeI5YMWM0sig3gWxDO6LaGvGMcJAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JugQ9Q48; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JugQ9Q48"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476b4c9faa2so6017071cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745454486; x=1746059286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8xiHmz6l58Zf9juB6tacJsT8mDdcuOlMyNOhcDtbek=;
        b=JugQ9Q48YB2cNSLvMNgGy3HI+lcHt+kuu2EUt+3/YJ3cO4lOUTqrvUGNGMIbOBD2ac
         Y8OHB0bCxmYoHqMZ013SDUis4kX2iOR51GVWEjzp2mmD+D/bczSylevz84m+cHbDIMoJ
         6Bi93gUaHEr+gDKBCf0rU+Lnu99sX8+kITcqR4cDNoq7Owl4GG+SPFLOVRPVymQSujB4
         Sc0obg+AQLWxIFLPa7OPfhng6abXK9wpE9w9eUZd5IoeoVlEYEuNg2jNmKAERuaV24Ah
         n5oeth54E1b6lL3tlGgbBDg5c55qsIhGkE02OyuGnkSH0KxSsHphXL9YUIyyOHC+W+Jc
         Pf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454486; x=1746059286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8xiHmz6l58Zf9juB6tacJsT8mDdcuOlMyNOhcDtbek=;
        b=NN5GG1AAoOmUBbK9SD4uHKMI+XBry06P07xz4BZXfvJNJehDPr7cadgiQ2jO4JMS+O
         eHBx2JWqHI+UNHF1anIz4olvrlKa5wQIpydR3NI00xr3AuOGLJkCYIil37jgWrxDhI2H
         VYyon5yvfLy5DF/CdbQAhnR7IIMQcOtsWdtuYZVuPnHIvYpeN0pS3ItaXp3+c5o8tRAa
         CNWqKQ+xidX0gxMaszdu1+aLUBFa/Jbq9m6pYjIOn4+6fZYID6Vj0gy2r/Npa7HEVGii
         qZAJB9jEWau9GKMWPDZV649LbxZuPDjwcaJeMxjGetan7sShOqoLxymL8ebOU2pZ5Odl
         OKQw==
X-Forwarded-Encrypted: i=1; AJvYcCUe9hGx6MRckv5orryeU5UTNf9b0Ip+yIsnG9po2MazhsS83gxwa9EXR3M65vAp8MV3aUMFTO2fwEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MAjC1K+Dopf3/dCEQnj4h0ATZ5qvibKdvXYM3TR8fx7I67SH
	cAPOu827ssN7hkLwVMX0fNLRigQgNUostH/FpOONT1ugpw82HS3lzF+5YCjp4Hg=
X-Gm-Gg: ASbGncvttwa3x9D23IrlQNUdILyHNRbfOLB3PyLvvFiBwTKHvczBgWosBLlLlwmP6KZ
	+eTxf35gXHetYaZFbCojvb7uuYVsD8Uiip3u4fo1rjjroSaAWeOynsM09JMkFjLGmDZWSN6kmpp
	TM3jqI/1R63BnrAPNLq+Ob24nYSbKiX1ycNzsZEpp5AqFN/IIusSfNrVK2a4DlYLUKl3T2ktjhI
	CO1F8peCtLqFeDbTcOFEiwRTRnbUvDBLfKosGji0iiBHREZJtx4T2wzF4IJN4fyWv/TnHzVuI1V
	vHe2FCahyewfUPy4/IMC8EsjsSKPGt0myO7+PJSuKsYwG9R4bsAJPQ9HTkeM/w0/qqHG4X9ZZiQ
	SQNY7HQpWqEDal1VsPqj9Q44=
X-Google-Smtp-Source: AGHT+IGnByHDgMG45Gdl1zjy6uCSmDPBy2o/HP/BPYo2mmBMn7Umr+TeI+0fJtWBOGffWKptPVhA0w==
X-Received: by 2002:a05:622a:199a:b0:477:ea0:1b27 with SMTP id d75a77b69052e-47eb33a68afmr6741001cf.26.1745454486518;
        Wed, 23 Apr 2025 17:28:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1d8f8edsm3229831cf.80.2025.04.23.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:05 -0700 (PDT)
Date: Wed, 23 Apr 2025 20:28:03 -0400
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
Subject: Re: [PATCH v2 06/15] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <aAmFk1iQcS7UpslQ@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-7-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-7-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:47PM +0100, Robert Richter wrote:
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d898c9f51113..5048511f9de5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -906,7 +905,7 @@ cxl_find_decoder_early(struct cxl_port *port,
>  		return &cxled->cxld;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> -		dev = device_find_child(&port->dev, &cxlr->params,
> +		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
>  					match_auto_decoder);

This semantic has now changed because of the linear caching set.

Working around this with something like this hack for now

Probably we want to pull the range out of the resource and put it right
in the params instead of the local variable, but just getting it working
for testing for now

~Gregory

---

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eac873125e6d..c8d38ce55045 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -833,7 +833,8 @@ static int match_free_decoder(struct device *dev, const void *data)
 }

 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       struct range *range)
+				       const struct range *range1,
+				       const struct range *range2)
 {
 	if (!p->res)
 		return false;
@@ -843,8 +844,8 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 	 * to be fronted by the DRAM range in current known implementation.
 	 * This assumption will be made until a variant implementation exists.
 	 */
-	return p->res->start + p->cache_size == range->start &&
-		p->res->end == range->end;
+	return range1->start + p->cache_size == range2->start &&
+		range1->end == range2->end;
 }

 static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
@@ -885,11 +886,15 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
 	return 1;
 }

+struct mad_context {
+	struct cxl_region_params *p;
+	struct range *r;
+};
 static int match_auto_decoder(struct device *dev, const void *data)
 {
-	const struct cxl_region_params *p = data;
+	const struct range *r;
 	struct cxl_decoder *cxld;
-	struct range *r;
+	const struct mad_context *ctx = data;

 	if (!is_switch_decoder(dev))
 		return 0;
@@ -897,7 +902,7 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;

-	if (region_res_match_cxl_range(p, r))
+	if (region_res_match_cxl_range(ctx->p, ctx->r, r))
 		return 1;

 	return 0;
@@ -916,13 +921,14 @@ cxl_find_decoder_early(struct cxl_port *port,
 		       struct cxl_region *cxlr)
 {
 	struct device *dev;
+	struct mad_context mad = { .p = &cxlr->params,
+				   .r =&cxled->cxld.hpa_range };

 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;

 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-		dev = device_find_child(&port->dev, &cxlr->params,
-					match_auto_decoder);
+		dev = device_find_child(&port->dev, &mad, match_auto_decoder);
 	else
 		dev = device_find_child(&port->dev, NULL, match_free_decoder);
 	if (!dev)
@@ -1363,6 +1369,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *iter = port;
+	struct range r;
 	u16 eig, peig;
 	u8 eiw, peiw;

@@ -1488,10 +1495,12 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -ENXIO;
 	}

+	r.start = p ? p->res->start : 0;
+	r.end = p ? p->res->end : 0;
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
+		    !region_res_match_cxl_range(p, &r, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
