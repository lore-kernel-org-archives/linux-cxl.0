Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7C19F471
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339499; cv=none; b=EnvhOt2NJSxiPeWMrh9Yryn8gEI1V7j36/PmnPngTo8wD8DytEEooYZkbZ+78x9NklznSw4ql3vz74jzj3Ods3SMHFDBoqEMg1ARWPyjNGpPGv4ec5MbGFTRCPCNjR0foXn71whttk+Oe5ttBWaJYCRRXwSt9q1QdUnvbMaGVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339499; c=relaxed/simple;
	bh=ydgnFdd28HnIExjXtLFKJzrXGHeAMFTu81kRytyoUdw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/aLeaTHiYlVBRhEUg/fBAJqjFSorDAy4PlMpiwF8w4x3Eju1k0AyAHWHQznIil9NK1eqQoIlZWU9U6WesCWM5hb00eoROp52PKtODJAreFKX/16rbYUhxntfX6Zh/r7KvzzhmR1G26BygVxxx1fS4O52hot64mNTaUL+f9w5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zhngn5n2xz6K9Dy;
	Wed, 23 Apr 2025 00:27:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A77131404F5;
	Wed, 23 Apr 2025 00:31:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Apr
 2025 18:31:33 +0200
Date: Tue, 22 Apr 2025 17:31:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 4/4] cxl/test: Add workaround for cxl_test for cxl_core
 calling mocked functions
Message-ID: <20250422173131.000047e5@huawei.com>
In-Reply-To: <20250404230049.3578835-5-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
	<20250404230049.3578835-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 15:57:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late host bridge uport mapping update changes in order to enable
> cxl-test.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Perhaps some more breadcrumbs (e.g. comments in the code) so we remember why this
dance is used?

Otherwise I think this is fine though I'm not entirely sure what happens
wrt to races and the  register_cxl_mock_ops() / unregister paths.

> ---
>  drivers/cxl/core/hdm.c        | 51 +++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h             | 16 +++++++++++
>  tools/testing/cxl/Kbuild      |  3 ---
>  tools/testing/cxl/test/mock.c | 34 +++++++++++++++--------
>  4 files changed, 82 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..ed6bdbd6b452 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -39,14 +39,19 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }
>  
> -/*
> +/**
> + * __devm_cxl_add_passthrough_decoder - Add passthrough decoder
> + * @port: The cxl_port context
> + *
> + * Return 0 on success or errno on failure.
> + *
>   * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
>   * single ported host-bridges need not publish a decoder capability when a
>   * passthrough decode can be assumed, i.e. all transactions that the uport sees
>   * are claimed and passed to the single dport. Disable the range until the first
>   * CXL region is enumerated / activated.
>   */
> -int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +int __devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport = NULL;
> @@ -73,6 +78,16 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  
>  	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
>  }
> +EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_passthrough_decoder, "CXL");
> +
> +cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder =
> +	__devm_cxl_add_passthrough_decoder;
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_passthrough_decoder, "CXL");
> +
> +int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +{
> +	return _devm_cxl_add_passthrough_decoder(port);
> +}
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");

>  void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
>  	list_add_rcu(&ops->list, &mock);
> +	_devm_cxl_setup_hdm = redirect_devm_cxl_setup_hdm;
> +	_devm_cxl_enumerate_decoders = redirect_devm_cxl_enumerate_decoders;
> +	_devm_cxl_add_passthrough_decoder =
> +		redirect_devm_cxl_add_passthrough_decoder;
>  }
>  EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>  
> @@ -23,6 +35,9 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
>  
>  void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
> +	_devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
> +	_devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
> +	_devm_cxl_add_passthrough_decoder = __devm_cxl_add_passthrough_decoder;

I doubt we actually care but should we ever need to reason about this sequence
for some reason, it would be better if it reversed that in register_cxl_mock_ops.

>  	list_del_rcu(&ops->list);
>  	synchronize_srcu(&cxl_mock_srcu);
>  }
> @@ -131,8 +146,8 @@ __wrap_nvdimm_bus_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);

