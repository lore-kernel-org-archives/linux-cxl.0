Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DF2D026
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/ypspo"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B26F8F
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 10:33:39 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7b91faf40so56445307b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Nov 2023 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295618; x=1699900418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dio2FgrUP6bZ4O0ycK6wilgfIXhwT7BUP7Rgbml0QMc=;
        b=M3/ypspooi9K1wweTkn5g+Y7ZLiT375vnCYIMRdmXpvbTMUpjlrxoH4mm9ha3olzdM
         Ws3La7UixKZzRQxD1gTmhzG310cOYjbZqfkToCCGU/vVchNxqfW7qb14obWsvGvLVG9c
         mz4l4HdyV0eiaE5czzwYR+Xz8gEtRCUcb3jz98RxpS9l9/O7TNmOpx4zMfe9B//RMbHC
         0Y8ULHdtzuyBy90te/Ftb5jTH3omNzcKmRop2CpsKkMGpa/PC5PA1iWyX2BARju3s1EB
         YgAn5hE2ygIcttvg+QTU1x/jPOBEAYA7SDbxPxvfLI/mb2vEq23xosSgbFq76D40Zjto
         6q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295618; x=1699900418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dio2FgrUP6bZ4O0ycK6wilgfIXhwT7BUP7Rgbml0QMc=;
        b=H7NLamvhwVQn2Y9dDGwlujXB0DtO6LPbT1Ze9vp7AcI1mQLdl+EXBvD1LyPAKbuJgk
         pSmULM2cioIpke7A+5bzvLPiHHQcvm+F39uTbl/Wt3lnew9tjO155oe2oS/DuXVN5VJv
         B5CXiS8o5fSi7WL/fkhqUXLlFBI/IrpHz1RbY0WQmkgAewrM3PkwdDX0bADk2x1wIxMx
         3PNg1nys5/ccTGrd5MIzxfDZBwq0g4sjbYKFNo63+UMYIM2S/69vNUanMF+OGueAmDh9
         1qh4uUg2+OuDAuBKE9BRboTULnmhmDfAZQjoZk4+EeB8SXOarB/ypibDTnGkC7YyJNFg
         W/RQ==
X-Gm-Message-State: AOJu0YwVZaShK/yY94h7kvRxW512yMoOqJs0UE7Sow8w6tgihYE+eI2z
	u4oowiUrml3XPtpUWStb88g=
X-Google-Smtp-Source: AGHT+IFY/48a8vMqI8SxTJdSQD1UIHr+/ko5FWF1LI2GiqU1a6hjukhXiftLKHfwTcxoBX/HEqErbg==
X-Received: by 2002:a0d:d848:0:b0:57a:8456:3401 with SMTP id a69-20020a0dd848000000b0057a84563401mr12610162ywe.29.1699295618594;
        Mon, 06 Nov 2023 10:33:38 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id bt12-20020a05690c072c00b005a7b785f66bsm4590078ywb.39.2023.11.06.10.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:33:38 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 6 Nov 2023 10:33:18 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v3] cxl: Add cxl_num_decoders_committed() usage to
 cxl_test
Message-ID: <ZUkxbneWzCH5imaS@debian>
References: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169929160525.824083.11813222229025394254.stgit@djiang5-mobl3>

On Mon, Nov 06, 2023 at 10:26:45AM -0700, Dave Jiang wrote:
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
> conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
> replace the open coding.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> ---
> v3:
> - Move export of symbol to cxl_test (Dan)
> v2:
> - Add missing changes, stg refresh foobar
> ---
>  tools/testing/cxl/Kbuild             |    1 +
>  tools/testing/cxl/cxl_core_exports.c |    7 +++++++
>  tools/testing/cxl/test/cxl.c         |    5 +++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/cxl/cxl_core_exports.c
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 90f3c9802ffb..95dc58b94178 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -62,5 +62,6 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
> +cxl_core-y += cxl_core_exports.o
>  
>  obj-m += test/
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> new file mode 100644
> index 000000000000..077e6883921d
> --- /dev/null
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +
> +#include "cxl.h"
> +
> +/* Exporting of cxl_core symbols that are only used by cxl_test */
> +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index b88546299902..f4e517a0c774 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -669,10 +669,11 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
>  		return 0;
>  
>  	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
> -	if (port->commit_end + 1 != id) {
> +	if (cxl_num_decoders_committed(port) != id) {
>  		dev_dbg(&port->dev,
>  			"%s: out of order commit, expected decoder%d.%d\n",
> -			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> +			dev_name(&cxld->dev), port->id,
> +			cxl_num_decoders_committed(port));
>  		return -EBUSY;
>  	}
>  
> 
> 
