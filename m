Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C4C433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Nov 2022 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKLGvG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 12 Nov 2022 01:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLGvG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 12 Nov 2022 01:51:06 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E311A23
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 22:51:04 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 979065417DE;
        Sat, 12 Nov 2022 06:51:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a314.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F2C635417E7;
        Sat, 12 Nov 2022 06:51:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668235863; a=rsa-sha256;
        cv=none;
        b=U0xptOyrBhw/ZLyp26lgcY1hYJdyFvPGpzfUjK04UhSdw1Sd2FOwVFp5mAfRs8FM/A3H+G
        iiNcxZFTff+LoHNystGBVz6HPA6weopm2fykRTd/QH3AZOnNqFn60estYqsS+Y6IGkIRSt
        Gikrkf3JWf0H5+Lsz8b7HF8c97qDkvmj2rO7oils1cAoxqnll4wt/HvidrkLeQUtKq7WRC
        BwJEICuF2whg4zlND0KRn4d5vay1UwHAzUEbEWep3WSJTKMO/N2XENd8qK5de00xmsXfI/
        9V4m9+qdZVmreCDNDSGWJnMjy+kVG/Q/YKr4OG48MOrj9psE+DkPc0eak5sGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668235863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/mDlpc79MlLl5BZFoSJtnJinlyHZm24LVqGZTVvVnGA=;
        b=B5hzIar8OPpEZEkWR7DBUE61t46zUJELojkAif1rnXujF5wqqnU3p767k6umLswbN5OIw5
        Z2Fv0iodBiGjowstaGayLcYq0vgbPLSKtixhtXqr4Oy9GxK5PTXraZe07hd0Q90ZCLINVY
        DpjHjoDh2zuygUoVrOGqHH2mO93H9i45CezK9MT2t8Qu61c8gvEIqpHyuY6H+JK7qX/zc6
        v+4PqqzFui0iVVutuQhra4UMMpSRhI6R6B8nkeh3+nX1gu5siKkqrd1krpy4ObLw3sVqZ0
        Krad4ljr1IpnLdJaiqoDXgS1wWwQwqAjS+eJxCyibfw+B8/65t6PiSu9bVd0uA==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-57d9b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Desert: 7c8c487a045b578c_1668235863398_625608711
X-MC-Loop-Signature: 1668235863398:78598606
X-MC-Ingress-Time: 1668235863398
Received: from pdx1-sub0-mail-a314.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.44 (trex/6.7.1);
        Sat, 12 Nov 2022 06:51:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a314.dreamhost.com (Postfix) with ESMTPSA id 4N8R6s3pbvzMy;
        Fri, 11 Nov 2022 22:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1668235862;
        bh=/mDlpc79MlLl5BZFoSJtnJinlyHZm24LVqGZTVvVnGA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=U/bzomILynV5qtDr0duSFApZP54HvrYIUSNgyvZYSSnvY5wMP59hoM+Eir+ih6X4S
         ZS4hDS28kMHfp7kzXO5BfjD1gM9xQoUuKMzZLnbNA9m2iHbU4q0KBgtxoabqXVac2p
         G58KwTYkAspc2YHtC4o6qP/Y3aH9XzRhTzhwYcNrjcnk2Xj/Zvj2Nsc7UKPuqeGjRi
         4BLk3gxUFzOVlGYow/Li7TJXm1N8XDjH+y5ZA9Bj3Z2VmjPdlMy9Wig7/ZrKWMWpeK
         85Q79tiCwiRnbFxacPVMO2ZNIXyOWfZERs59RBLptW4E/S9wfWaiehD+Y4xRRkdeds
         NjnTTi95owC0w==
Date:   Fri, 11 Nov 2022 22:28:23 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <20221112062823.4mrp4kz6hxsd3uxw@offworld>
References: <cover.1668227077.git.alison.schofield@intel.com>
 <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 11 Nov 2022, alison.schofield@intel.com wrote:

>+static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>+			   const unsigned long end)
>+{
>+	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
>+	struct cxl_cxims_context *ctx = arg;
>+	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
>+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>+	struct device *dev = ctx->dev;
>+	struct cxims_data *cximsd;
>+	unsigned int hbig, nr_maps;
>+	int rc;
>+
>+	rc = cxl_to_granularity(cxims->hbig, &hbig);
>+	if (rc)
>+		return rc;
>+
>+	if (hbig == cxld->interleave_granularity) {
>+		/* IW 1,3 do not use xormaps and skip this parsing entirely */
>+
>+		if (is_power_of_2(cxld->interleave_ways))
>+			/* 2, 4, 8, 16 way */
>+			nr_maps = ilog2(cxld->interleave_ways);
>+		else
>+			/* 6, 12 way */
>+			nr_maps = ilog2(cxld->interleave_ways / 3);
>+
>+		if (cxims->nr_xormaps < nr_maps) {
>+			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
>+				cxims->nr_xormaps, nr_maps);
>+			return -ENXIO;
>+		}
>+
>+		cximsd = devm_kzalloc(dev,
>+				      struct_size(cximsd, xormaps, nr_maps),
>+				      GFP_KERNEL);

Need to check for failed kzalloc.

>+		memcpy(cximsd->xormaps, cxims->xormap_list,
>+		       nr_maps * sizeof(*cximsd->xormaps));
>+		cximsd->nr_maps = nr_maps;
>+		cxlrd->platform_data = cximsd;
>+		cxlrd->calc_hb = cxl_hb_xor;
>+	}
>+	return 0;
>+}
>+
> static unsigned long cfmws_to_decoder_flags(int restrictions)
> {
>	unsigned long flags = CXL_DECODER_F_ENABLE;
>@@ -33,11 +130,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>	int rc, expected_len;
>	unsigned int ways;
>
>-	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
>-		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
>-		return -EINVAL;
>-	}

It seems more robust to keep the check and just add the ACPI_CEDT_CFMWS_ARITHMETIC_XOR case.

>-
>	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
>		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
>		return -EINVAL;
>@@ -84,6 +176,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>	struct cxl_cfmws_context *ctx = arg;
>	struct cxl_port *root_port = ctx->root_port;
>	struct resource *cxl_res = ctx->cxl_res;
>+	struct cxl_cxims_context cxims_ctx;
>	struct cxl_root_decoder *cxlrd;
>	struct device *dev = ctx->dev;
>	struct acpi_cedt_cfmws *cfmws;
>@@ -148,7 +241,33 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>		ig = CXL_DECODER_MIN_GRANULARITY;
>	cxld->interleave_granularity = ig;
>
>+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
>+		if (ways == 1 || ways == 3)	{
>+			/* Skip CXIMS parsing for IW 1 or 3. No xormaps used */
>+			cxlrd->calc_hb = cxl_hb_xor;
>+			goto decoder_add;
>+		}
>+
>+		cxims_ctx = (struct cxl_cxims_context) {
>+			.dev = dev,
>+			.cxlrd = cxlrd,
>+		};
>+
>+		rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
>+					   cxl_parse_cxims, &cxims_ctx);
>+		if (rc < 0)
>+			goto err_xormap;
>+
>+		if (cxlrd->calc_hb != cxl_hb_xor) {
>+			rc = -ENXIO;
>+			goto err_xormap;
>+		}
>+	}
>+

I'm not crazy about now having different layers setting the ->calc_hb callback. Normally
this is done when cxl_root_decoder_alloc(), and now it gets overwritten and reassigned in
both parser calls (cfmws and cxims). How about just moving it out of the cxlrd allocation
call and doing it all here in cxl_parse_cfmws()? You can also avoid the decoder_add goto.

	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
		if (ways != 1 && ways != 3) {
			// arm cxims_ctx
			rc = acpi_table_parse_cedt();
			if (rc < 0)
				goto err_xormap;
		}

		cxlrd->calc_hb = cxl_hb_xor;
	} else
		cxlrd->calc_hb = cxl_hb_modulo;

>+decoder_add:
>	rc = cxl_decoder_add(cxld, target_map);
>+
>+err_xormap:
>	if (rc)
>		put_device(&cxld->dev);
>	else
