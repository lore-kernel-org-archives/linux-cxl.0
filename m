Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B417462;
	Mon, 21 Jul 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107418; cv=none; b=PDDjxc5lhnWw94fTrhfhKqYO1vkGtO2msO7LyqxY6z8FuyTrWaDPb4wWYF856oeb5QWWWvqPURdVshg2jcrvDx373wdcj4cEloqh8WN5u/JPwQntntCSYBdCieTKOrZlKAAsgVAoC1v4hpVHXSzctoSyxct+w6BsUrcVi+/j8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107418; c=relaxed/simple;
	bh=P3UIwtVZaRYvpiQ2hIC/+Fx6PVr1AcxjBxpzVopZ240=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIyWoA7kJpv6EdN6JBnJ+HyV3UwIwezFKcgdo8esT8OMVHkXTj/9/5f3IWgZkZc07uCRnLJrlkNbeId7R5ssMcE7FSdyxDdzjPg7HXwmvM8oiDKVbYArMQ7rKb3DKvdem1ym2bVsB1w+jsiInvtfLS9wE5yYsrYfEsFKvQNShQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLVqOXD3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLVqOXD3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7170344c100so36464467b3.0;
        Mon, 21 Jul 2025 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107415; x=1753712215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6YwRJnlJ+cRW/GyuJIckdpGwbgGAubB75oLrU1WLiU=;
        b=dLVqOXD3H7MENcCKt6eeTYymvRAy2L/72gh5UTM1CRACgP1+1r+OQ04yZWk23WgR+I
         ZeScofvp6bPG6neRtEnSY28YdPC0kC+5ajJH4aMXiMgueV99glOK79TsFrFk4ebfQUxf
         KCpJFwFOj5bWTvA8OMyGAder8jV6VtDHfWXY3dUdsGNoALz0WtZEmXGIMFJyBD7bMe8g
         LJriOGF0CWyGtl9f4WB35VO3SNjpGPfCsF+tGNO1nZkLd0VUP0/02AGIJBjIDHJXhXKj
         WBbAxJva4rVOXfD7KbbVFBHpHoLpwPXcWISa8NQ/bpW+R44xs0DvnBFkuUastS46tohO
         CB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107415; x=1753712215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6YwRJnlJ+cRW/GyuJIckdpGwbgGAubB75oLrU1WLiU=;
        b=Gab3vWZUa39DUyL66eSr95Qtw8+Lr4FNovgMZbJBAQDudN83XvmkWTnd7oHLQRXXOw
         5ZAX2l6Q9yOsjoRoACPYqWHC6mw0rYME1x4CeQur3ESQl4qY89J3wYKp7XpSIpOu3mLM
         sLaavOqkedHRnr2VHW844x2Tkssj9wqBpENcsekU2F9OBw14T6zwiyycswDdgKUKagBf
         eEz79PAwcFo/kQsLtw9B8W2lfnkTMntNC3qRoUqXdaP1laJ2a2Y5/kgOEhXJNyKkyPGt
         XFY39iSUk+MHBjy+bdxq0KJBV7ogrKE3qDE4LH4TgODdCTESaLDg2fbb0jJ4rcM6xxd0
         l1lg==
X-Forwarded-Encrypted: i=1; AJvYcCX1YYCqGQk0nfIgr29J0/vhztb2I4MkMy2lZoHnzSkqbdT9rZCcxP+PxPObbIQY3xu9a6bZUiUhQFU=@vger.kernel.org, AJvYcCXkIyXzhp5YCYzWzQwTx+YPGuloAfMo0pZA3vHRnHDXZ27KvvgV3AlP+32tX1otCg7xefcj649v+4h6mZ7P@vger.kernel.org
X-Gm-Message-State: AOJu0YxNif0UeID35WmitGDu+bk/IY/Wa8GSy8fnJ/bvhk1BtXxfLu4I
	puxe+XCrLr+8/A8hVnP5rgBICPIRnXsFAzQs01CtkfzbDtRieJgu2mj9
X-Gm-Gg: ASbGncsB60G2X9AuCCopj3L52qS2WP/YYKNBD/i0mJceot5cHj1IN9MDn1/3ULJzZkn
	bUJ9D0xZfPkUADlBBduZa3wfpKOPoujq2WRLfN3uNIhw53bFC6X9MUEVSjr9Sn5hA3C0oBLbthy
	yC42RGCosJhanHV1EslFc6aIHSPGKz9f5ZmRRABk7ue7xWNAhUt27p5LQeNRl0IZA0tSyiJ6WjN
	pE0CQNfvyni4hdUx1eNx7PlEm/xluO+um+qChR49GQEzakpnclnVZcphRwRngFycU1b5Ra/YGVb
	+kqQ53Z9KZkd7VlP5JY1qIJ32grdLq69Cl8C+UOubhvnbTryD/ypo04MKSCD31iDFWx3xkDEEN7
	a89fSXEfCTWe1busbRqcayg==
X-Google-Smtp-Source: AGHT+IHZxGyUoSg1wWSx4jtOTu/PK8Etqd9t7suc0yd/8NtrJm+MmtdYqXsqsve+b9X2vupNR2Pirw==
X-Received: by 2002:a05:690c:4809:b0:70c:a57c:94a3 with SMTP id 00721157ae682-718374f0513mr215033837b3.19.1753107414959;
        Mon, 21 Jul 2025 07:16:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce0e41fsm2518387276.26.2025.07.21.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:16:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 05/20] cxl/region: Separate cxl_region_alloc() from devm_cxl_add_region()
Date: Mon, 21 Jul 2025 07:16:52 -0700
Message-ID: <20250721141653.89805-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715191143.1023512-6-rrichter@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 21:11:28 +0200 Robert Richter <rrichter@amd.com> wrote:

> In interleaving configs multiple endpoint decoders connect to the same
> region. The region's parameters must be the same for all endpoint
> decoders that share the interleaving setup. During initialization, the
> region's parameters are determined for each endpoint decoder.
> If a region for the same hpa range already exists, no new region is
> created and the existing one is reused.
> 
> To simplify region setup and the collection of the region parameters,
> separate region allocation from its registration. This allows it to
> allocate and setup a region before checking the parameters with
> existing other regions and adding it to the cxl tree or releasing it
> and instead reusing an existing region.
> 
> Here, only separate cxl_region_alloc() from devm_cxl_add_region().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

Hello Robert,

Thank you for this great patch! I have one small nit:

>  /**
> - * devm_cxl_add_region - Adds a region to a decoder
> - * @cxlrd: root decoder
> - * @id: memregion id to create, or memregion_free() on failure
> - * @mode: mode for the endpoint decoders of this region
> - * @type: select whether this is an expander or accelerator (type-2 or type-3)
> + * devm_cxl_add_region - Adds a region to the CXL hierarchy.
> + * @cxlr: region to be added
> + * @id: memregion id to create must match current @port_id of the
> + *      region's @cxlrd
>   *
>   * This is the second step of region initialization. Regions exist within an
>   * address space which is mapped by a @cxlrd.
>   *
> - * Return: 0 if the region was added to the @cxlrd, else returns negative error
> - * code. The region will be named "regionZ" where Z is the unique region number.
> + * Return: Pointer to the region if the region could be registered
> + * (for use in a tail call). The region will be named "regionZ" where
> + * Z is the unique region number. On errors, devm_cxl_add_region()
> + * returns an encoded negative error code and releases or unregisters
> + * @cxlr.
>   */

It seems like the changes that this new return description corresponds to
were actually made in the previous patch. Would it make sense to move this
new description to the previous patch?

> -static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> -					      int id,
> -					      enum cxl_partition_mode mode,
> -					      enum cxl_decoder_type type)
> +static struct cxl_region *devm_cxl_add_region(struct cxl_region *cxlr, int id)

Otherwise, LGTM!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Sent using hkml (https://github.com/sjp38/hackermail)
