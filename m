Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCD36EAAD
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196936; cv=none; b=nF//VKHjOoyS2EpKwjXfXBnM6k90J1OIG2XnvbjWHWWw17zrEJzBZ/F8jSkjCQoLM8NYYrXBhfJZ7WjcEYTf1wntciDjSyTbtpkhptegav5jORin5ZzYRBSUjtpioTkCAxMH8TxaWBb9YOi7IIvmbsZC6CBoQMeNB/eQUOzVUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196936; c=relaxed/simple;
	bh=kmo+q7PQxuYkeoc1Ef0o1IUx9iN8EycBEsb0eZbxc48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULKjxyvGxe95+1Bgrll43wV9vdlwUPMFE8nVq/Ytn86nEt6fiIQTWZt7NWTyDax8vmT4URLFlsuy2bg4CyyiX1tI4VnexAHjJG5+4QPOCAwaXGQwCbzFUJHutSUb/qSYCLCWGd67CNw//p7RuKH3xJdec0QVxepEqZ3ACOQmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnh6CyKs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnh6CyKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778196934; x=1809732934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kmo+q7PQxuYkeoc1Ef0o1IUx9iN8EycBEsb0eZbxc48=;
  b=cnh6CyKsgQbi6jM8RsMAdTCHGGI4mz/A7Xkwp/eH+6KGDaEFDtjVlNOJ
   gNWivjeQ0A8xx3bxaG8URPe1459DR3A3v93EfXPcvbcCMxv/jbAcy/9Bq
   Cz737h5/1LU81KzaO+4VQLpgIfBA1k57r4Fxlo3L1qE2JdtqJJxkBdHyN
   noOFWvx+ZzB7fzMy1iJhqAlawzpo9ZcwLSPkOjZnslrlw8Z1/b6SJmpMN
   O0QZUt2B8qm9fxP1vlpOBYc1eRQ9iDeovIiQKoRXua4BXAEzcOK04QYWb
   FY9Kn6Ddex+gQEOTtf1DCEQF4bnvxOG9AmxO06LOqqipZOGci9uMldezM
   g==;
X-CSE-ConnectionGUID: ydCD35bCQASpRaXfW6nZig==
X-CSE-MsgGUID: ZPbXWqpzQHafy0CQllI5cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90622634"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90622634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:35:33 -0700
X-CSE-ConnectionGUID: VxJt/IHBSgq9L/we4QyzWA==
X-CSE-MsgGUID: GtPRugRfTYuqveEGUQ4u5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="238401103"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:35:32 -0700
Message-ID: <ee6a45be-7905-470d-b546-7317f09aab12@intel.com>
Date: Thu, 7 May 2026 16:35:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] cxl/test: Refactor mock_init_hdm_decoder() to prep
 for type2 decoder
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-2-dave.jiang@intel.com>
 <afrELziKpyUDuZXS@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrELziKpyUDuZXS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 9:31 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:31PM -0700, Dave Jiang wrote:
>> Split mock_init_hdm_decoder() into different types of initialization.
>> Currently the code deals with default initialization, saved decoders,
>> and type3 auto region initialization. In the future, a type2 auto
>> initialization will also be added. This refactor will make it cleaner
>> to add additional init types.
> 
> Nice refactor! A couple of nits below...
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  tools/testing/cxl/test/cxl.c | 184 ++++++++++++++++++++++-------------
>>  1 file changed, 115 insertions(+), 69 deletions(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index cd47fdd7ccb5..c26c37cef12c 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1052,74 +1052,25 @@ static int first_decoder(struct device *dev, const void *data)
>>  	return 0;
>>  }
>>  
>> -/*
>> - * Initialize a decoder during HDM enumeration.
>> - *
>> - * If a saved registry entry exists:
>> - *   - enabled decoders are restored from the saved programming
>> - *   - disabled decoders are initialized in a clean disabled state
>> - *
>> - * If no registry entry exists the decoder follows the normal mock
>> - * initialization path, including the special auto-region setup for
>> - * the first endpoints under host-bridge0.
>> - *
>> - * Returns true if decoder state was restored from the registry. In
>> - * that case the saved decode configuration (including target mapping)
>> - * has already been applied and the map_targets() is skipped.
>> - */
>> -static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>> +enum cxld_init_type {
>> +	MOCK_DECODER_INIT_DEFAULT,
>> +	MOCK_DECODER_INIT_SAVED,
>> +	MOCK_DECODER_INIT_TYPE3_AUTO,
>> +};
> 
> skip
> 
>> +/*
>> + * Initialize a decoder during HDM enumeration.
>> + *
>> + * If a saved registry entry exists:
>> + *   - enabled decoders are restored from the saved programming
>> + *   - disabled decoders are initialized in a clean disabled state
>> + *
>> + * If no registry entry exists the decoder follows the normal mock
>> + * initialization path, including the special auto-region setup for
>> + * the first endpoints under host-bridge0.
>> + *
>> + * Returns true if decoder state was restored from the registry. In
>> + * that case the saved decode configuration (including target mapping)
>> + * has already been applied and the map_targets() is skipped.
>> + */
>> +static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>> +{
>> +	struct cxl_endpoint_decoder *cxled = NULL;
>> +	struct platform_device *pdev = NULL;
>> +	struct cxl_test_decoder *td;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_port *port;
>> +	bool hb0 = false;
>> +
>> +	if (is_endpoint_decoder(&cxld->dev)) {
>> +		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>> +		cxlmd = cxled_to_memdev(cxled);
>> +		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
>> +		pdev = to_platform_device(cxlmd->dev.parent);
>> +
>> +		/* check is endpoint is attach to host-bridge0 */
>> +		port = cxled_to_port(cxled);
>> +		do {
>> +			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
>> +				hb0 = true;
>> +				break;
>> +			}
>> +			if (is_cxl_port(port->dev.parent))
>> +				port = to_cxl_port(port->dev.parent);
>> +			else
>> +				port = NULL;
>> +		} while (port);
>> +		port = cxled_to_port(cxled);
>> +	} else {
>> +		port = to_cxl_port(cxld->dev.parent);
>> +	}
>> +
>> +	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
>> +	case MOCK_DECODER_INIT_SAVED:
>> +		if (!td)
>> +			return false;
> 
> get_decoder_init_type never returns NULL w _SAVED.
> 
> suggest replace w
> 		if (WARN_ON(!td))
> 			return false;
> 

ok

> 
>> +		return mock_decoder_handle_saved(cxld, td);
>> +	case MOCK_DECODER_INIT_DEFAULT:
>> +		/*
>> +		 * The default path picks up all the decoders that are not
>> +		 * endpoint.
>> +		 */
>> +		default_mock_decoder(cxld);
>> +		return false;
>> +	case MOCK_DECODER_INIT_TYPE3_AUTO:
>> +		mock_init_hdm_type3_cxled(cxled, port, pdev);
>> +		return false;
>> +	default:
>> +		return false;
> 
> default is unreachable since the enum has 4 names values.
> suggest dropping it.
> 

ok
> 
>> +	}
>>  }
>>  
>>  static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>> -- 
>> 2.53.0
>>

