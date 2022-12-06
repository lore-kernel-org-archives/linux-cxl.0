Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED5C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiLFG1g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFG1f (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:27:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BCD275EC
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670308048; x=1701844048;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oNajPe1FgemyWIOe44GyPzCfBjuo2XNO4X/mNo+zpHI=;
  b=Zqa1d40OaRT7AEpl0POTcKFypk+t6BGCmG/7wn0peyJ9Wl850lZ7j3a8
   9em7p2gU1n5RsyRH0XWkqIDvjyDoSh1R7RUj4iBAY3CICZilgzbIGzckd
   xObatRgrw7jBr7zM5XvXGzbLMSL65bZDg4aLbROP3Jkao9VXtnU4P7Wqo
   PukTjvE7Tt6aVNi87xXDNfJ3I36bkaZvaq3tUsU42gfHCkpmipLvqOrPa
   sUgpYlVC4dCYSyI2J8eeAXEA/cvbzW61RHmGL6i4UiYNS8pGUta9/AWWg
   mMqWY7PzgJhO1SEI1onuMWH3QjC7gMjA3CN6/84mxRIMGPOcNaFzGQ+NM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343567316"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343567316"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:27:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="891259480"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="891259480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2022 22:27:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:27:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:27:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:27:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:27:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF83r5Nf0Wv+wesc6ivZdT6G9fRDL/myN9VaIYCSFEBzBOUnLxNmpD/09kY89RDNOsPUPhAebqmdwxDujixNuxEF7ZsF9m4IsNuooXZP6a4RjXlEsu2eEUppoCXeWzuj0BadTgshsyUYKHtfWJTZg+w1C4+0L0csMCF3tj+H9SGEv+wI36AS2c7NONHMCLsAPUULaPyoW/agh1EJhTDnzeI7sBUgNaHy3dl4Bt9saSoQgfjhmaEXgLyW8YMrkrvR7cL1lKJtwkfLuj60RfLDulXEMO1SgHuKCqZm/6dYH3bdaxAppvEavEtG7YDOUb9KAGZrzJjEykC/A3JLFnrj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y22NpmPBWvitOSULh0F8EYAm1NxSmP7qKTXmkLR3jKU=;
 b=fo1jtOv84F6rRCv4zyX8S557k225j5CqW47mjhDeaFGu3McD6IL/qPyPLQzzTaDF8Ig8oNSQI5FPSSBFIgZ6aRTYF5QiUDKLZlz57sy+u1w5z5BAWHgsSxP+m1pQbbc27954RfKNBQA4rjnhde7iJRl8iFqek1hwULfUUbvc9nweLsbmTuD4Tt12YWcXdQAOpzoyevDavUhfkaoA19s/ZPumWs+WDBKBO7LFXcNxbQPWT3fFmTb50wnviHvRSb/YGHN7A9MQyVEcCLwD2LSllnEJglwmVd/mkOF8SHFie67m2JBEwYVzss6EXShKLz0n3p2KdPMmHOfMyKzrWTirOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5484.namprd11.prod.outlook.com (2603:10b6:408:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 06:27:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:27:24 +0000
Date:   Mon, 5 Dec 2022 22:27:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 2/4] cxl/mbox: Enable cxl_mbox_send_cmd() users to
 validate output size
Message-ID: <Y47gx7E8ZnCjITQl@iweiny-desk3>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030055370.4044561.17788093375112783036.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030055370.4044561.17788093375112783036.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: fd39936b-fc2f-4730-74af-08dad752eff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2YLO4WmLKB1rox9h/Ch+pUy4RU15boduT1Ufug3X6U4Td2fKnmJ6qQi3uS7Hx2YPoisoZi6O4QwK2VhtJO76zwRYuvWEq1cXVLF4sMXjsxYKsN+tZiwDsV1H+CKFoX9Se4w/ANlAuH2MfbvX+z6tSB9ehGaAgNWwGxSubcRRat54z/aPK4DnuNeczSGCD3oHDwnu/EfTS7dN7WhkxtyrbSgyqDXuEXYU5Y7vvTadAZf8csrImhgLACj3hTk8J/leLw17SMws/gWHF/FnaLCRT2JQqaJW5QSMvBtv/qmvNP+G2l+PwzfB7y6Ra6HVUWFyhwf4Ir0tD6sETv09vo3jC7iVervqPz866kmn4d4bX3jFBnxdpi6O/acbN8TW52YX/YS9SMogO4++/1Dg64VhnNCITig1bZLdpAavQz4Tehw83+WhlNBMkqnXm74DDcJ6Naf6rT4A8d22e4Z52oBSNyJXYtV5T0ZRPZy9JQMRvCagmHn8POjmHHUyLAx/+jqPWAqNw2ICpdd2aoifM1wsdq2AVEDtuSTm88SY5kDNTofKrzkmKvNNV1bic4b2glvUjVCvz/XS2Tq6HUph6SZga3u9hY3yShB7XdQ199PniPBe1NCAl383sxuL+SlaBA9ZUUCCd3AEzWS/tIvNuc35Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(83380400001)(86362001)(38100700002)(82960400001)(30864003)(2906002)(41300700001)(4326008)(8936002)(5660300002)(15650500001)(44832011)(6862004)(8676002)(33716001)(186003)(6506007)(6512007)(26005)(9686003)(6666004)(107886003)(316002)(6636002)(6486002)(66556008)(478600001)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKvlwf0jrfIh/3nx54tzCuarsHceoOghuXIipdK73CoL+JLrGsFRUEYO0G/6?=
 =?us-ascii?Q?Tcyera7/tlQALmBKynct8XhnoSKi5KgwWt6rJBwQzwTXUX/8iYvQ/+1470t9?=
 =?us-ascii?Q?CG0K5fFo8n53L95owqxsIFhf5CJu6VFsuljMlCaBVawlnd6rgYQ7bRb4lJ55?=
 =?us-ascii?Q?A9xinp1QLcQg0GdCq2nUEfodB92X8dWncRbCCNsfoPmZgEcCJ6XDhL1J3oZ+?=
 =?us-ascii?Q?22EkBTqRq6ScEkQmdyhcuna9NQs+bUWTscNnCp8jxXW8T4PCqvy9FVv921cp?=
 =?us-ascii?Q?y9Kd9tw2eKYpyYYUum3X8ZWBhxDLOcS+Nz2Rr8LEjPqjgcYw3BZYKbTCOgqv?=
 =?us-ascii?Q?h+ekkrbN/AalFJF+z/WJTbU6INHqIsOiTN4bHHmioJsInWZNahDBydyqJiVx?=
 =?us-ascii?Q?YeKxeEmTgF8xJ1JRMWY4VPbVd7K8vZET7X+HfmQLgDMDNUviy2WxknvpK113?=
 =?us-ascii?Q?iPvNTCMuCUzy5jHLxFz/JbQXUG19thFlr95cPEksjRVZKQf4Czi2DBmVnHul?=
 =?us-ascii?Q?oPuQIIn8qvGi77h21Ht/4Az0eOza0Q2UnSCd/M2OX/fMKxdWwsr0y5yHJ0FK?=
 =?us-ascii?Q?g4oN1a64gIqi7hPK4JNQgo54LsDqi/yfgT/P9nNQUkT8XGHNhaEOvzOLrVnj?=
 =?us-ascii?Q?BTlKGl4dX5bSfUU1GI4DYUobc0krqqR/dLFSaQNWV0V4u/lmhSW25+hJN6R/?=
 =?us-ascii?Q?IGkLgdxiiRD5Ny4TIi9lsp3XpFsYj7uRiO22jJuQmbfk74kruJ1QW2pGPbjQ?=
 =?us-ascii?Q?ID/JXYyWtgAU2rbBMT4q9i64eDQwkanrczyB79HhiTjKupYwpnp69mUCigun?=
 =?us-ascii?Q?xh3kHkW52CNoikHRSM/zLmTPYtXmiKchGvilPLl5cJ8nGqBIgr2FeMoaLtZc?=
 =?us-ascii?Q?VTWV6qC8ru9Y6/G1bz6CzfrEUbdnQLM0qFkb75QA4cXR0yiIdP3C4PpUTWz9?=
 =?us-ascii?Q?x5AL/SMVQQx1U53zot5kg8STdrmZEHA17oTst109wIM2cWwuvdrsD013VM15?=
 =?us-ascii?Q?avvJfDEifaPsDlTLoBudDhIfdmuVnB+STQYb3f+V6yNO9nXGDBXNqysjgQLz?=
 =?us-ascii?Q?Eb9bg9bxMXpQktxLwSzg7rSg+13Pq6VWD8KFOxZ9stS4hdOugSiRraqe3MJc?=
 =?us-ascii?Q?BErZt1A8ZYs7nlIpSJyv2r4VtT6jLmB7M3BJcxS5XCw0Ep/rQR/CjLtxnl0F?=
 =?us-ascii?Q?v7iqJ31r7ZYC478RWxo3ZfGqiMpzLRrw1ItJgyDto8SVAvssobKRScQ9rPGL?=
 =?us-ascii?Q?vwS+BxJy3LMVEhTg2JhyTt1f1Azbou4gCf+LU23C6PShaMI+x2Q/YZhAJbxw?=
 =?us-ascii?Q?BDnj93L7XGHnv7z7HAgmeWPKKZlTrzZDAAUySiVF9nTWgJHVcaeFXaY4I5MD?=
 =?us-ascii?Q?KrUCI/8h4pBD50UIZZwR1EusQPsozDRZxtBOsvRvsr+FXiyh3uTAow9jh8VK?=
 =?us-ascii?Q?5ojF/bcFO5Ss7MUqvuUtonFi7x8Zz8KhDVNCYxgjLE5BH2WdNMD+RiYdcp7F?=
 =?us-ascii?Q?ydDbuz7hX5yjIycJjzk90uyAaXkNYWxNCFT4MxnTekk+9Nrnb9UWQCSsbNpj?=
 =?us-ascii?Q?PuczVtkimn1dvEElIKbXo9GNJVS1VEng853DqRLD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd39936b-fc2f-4730-74af-08dad752eff0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:27:24.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhTR6h6rl3oiZ1482GbRvdbyvvZYlC6t9i26qZrS/brs0OCG+A0h/NNeFjB4lP2gvb1HKKWJYS9PUNwNr0ul9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5484
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:22:33PM -0800, Dan Williams wrote:
> Internally cxl_mbox_send_cmd() converts all passed-in parameters to a
> 'struct cxl_mbox_cmd' instance and sends that to cxlds->mbox_send(). It
> then teases the possibilty that the caller can validate the output size.
> However, they cannot since the resulting output size is not conveyed to
> the called. Fix that by making the caller pass in a constructed 'struct
      ^^^^^^
      caller

> cxl_mbox_cmd'. This prepares for a future patch to add output size
> validation on a per-command basis.
> 
> Given the change in signature, also change the name to differentiate it
> from the user command submission path that performs more validation
> before generating the 'struct cxl_mbox_cmd' instance to execute.
> 

Minor comments below.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c |   86 ++++++++++++++++++++++++++++-------------------
>  drivers/cxl/cxlmem.h    |    4 +-
>  drivers/cxl/pmem.c      |   21 +++++++++--
>  drivers/cxl/security.c  |   77 +++++++++++++++++++++++++++++++-----------
>  4 files changed, 126 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 35dd889f1d3a..ed451ca60ce5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -146,13 +146,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  }
>  
>  /**
> - * cxl_mbox_send_cmd() - Send a mailbox command to a device.
> + * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
>   * @cxlds: The device data for the operation
> - * @opcode: Opcode for the mailbox command.
> - * @in: The input payload for the mailbox command.
> - * @in_size: The length of the input payload
> - * @out: Caller allocated buffer for the output.
> - * @out_size: Expected size of output.
> + * @mbox_cmd: initialized command to execute
>   *
>   * Context: Any context.
>   * Return:
> @@ -167,40 +163,37 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * error. While this distinction can be useful for commands from userspace, the
>   * kernel will only be able to use results when both are successful.
>   */
> -int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
> -		      size_t in_size, void *out, size_t out_size)
> +int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> +			  struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> -	struct cxl_mbox_cmd mbox_cmd = {
> -		.opcode = opcode,
> -		.payload_in = in,
> -		.size_in = in_size,
> -		.size_out = out_size,
> -		.payload_out = out,
> -	};
> +	const struct cxl_mem_command *cmd =
> +		cxl_mem_find_command(mbox_cmd->opcode);
> +	size_t out_size;
>  	int rc;
>  
> -	if (in_size > cxlds->payload_size || out_size > cxlds->payload_size)
> +	if (mbox_cmd->size_in > cxlds->payload_size ||
> +	    mbox_cmd->size_out > cxlds->payload_size)
>  		return -E2BIG;
>  
> -	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
> +	out_size = mbox_cmd->size_out;
> +	rc = cxlds->mbox_send(cxlds, mbox_cmd);
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> -		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>  
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the
>  	 * caller to do that if they wish.
>  	 */
>  	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
> -		if (mbox_cmd.size_out != out_size)
> +		if (mbox_cmd->size_out != out_size)
>  			return -EIO;
>  	}
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
>  
>  static bool cxl_mem_raw_command_allowed(u16 opcode)
>  {
> @@ -567,15 +560,25 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  
>  	while (remaining) {
>  		u32 xfer_size = min_t(u32, remaining, cxlds->payload_size);
> -		struct cxl_mbox_get_log log = {
> +		struct cxl_mbox_cmd mbox_cmd;
> +		struct cxl_mbox_get_log log;
> +		int rc;
> +
> +		log = (struct cxl_mbox_get_log) {
>  			.uuid = *uuid,
>  			.offset = cpu_to_le32(offset),
> -			.length = cpu_to_le32(xfer_size)
> +			.length = cpu_to_le32(xfer_size),
> +		};
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_LOG,
> +			.size_in = sizeof(log),
> +			.payload_in = &log,
> +			.size_out = xfer_size,
> +			.payload_out = out,
>  		};
> -		int rc;
>  
> -		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
> -				       out, xfer_size);
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  		if (rc < 0)
>  			return rc;
>  
> @@ -621,19 +624,25 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_mbox_get_supported_logs *ret;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
>  	ret = kvmalloc(cxlds->payload_size, GFP_KERNEL);
>  	if (!ret)
>  		return ERR_PTR(-ENOMEM);
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
> -			       cxlds->payload_size);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
> +		.size_out = cxlds->payload_size,
> +		.payload_out = ret,
> +	};
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0) {
>  		kvfree(ret);
>  		return ERR_PTR(rc);
>  	}
>  
> +

extra...

>  	return ret;
>  }
>  
> @@ -735,11 +744,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_mbox_get_partition_info pi;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
> -			       &pi, sizeof(pi));
> -
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_PARTITION_INFO,
> +		.size_out = sizeof(pi),
> +		.payload_out = &pi,
> +	};
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc)
>  		return rc;
>  
> @@ -768,10 +781,15 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  {
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> -			       sizeof(id));
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_IDENTIFY,
> +		.size_out = sizeof(id),
> +		.payload_out = &id,
> +	};
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 785c6c12515d..c447577f5ad5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -430,8 +430,8 @@ enum {
>  	CXL_PMEM_SEC_PASS_USER,
>  };
>  
> -int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
> -		      size_t in_size, void *out, size_t out_size);
> +int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> +			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 2fc8070b6a17..eedefebc4283 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -119,6 +119,7 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
>  				    unsigned int buf_len)
>  {
>  	struct cxl_mbox_get_lsa get_lsa;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
>  	if (sizeof(*cmd) > buf_len)
> @@ -130,9 +131,15 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
>  		.offset = cpu_to_le32(cmd->in_offset),
>  		.length = cpu_to_le32(cmd->in_length),
>  	};
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_LSA,
> +		.payload_in = &get_lsa,
> +		.size_in = sizeof(get_lsa),
> +		.size_out = cmd->in_length,
> +		.payload_out = cmd->out_buf,

FWIW NIT: I find it harder to review when the initializers are out of order WRT
the struct definition.  ie should be in, in_size, out, out_size for each of
these.

> +	};
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
> -			       sizeof(get_lsa), cmd->out_buf, cmd->in_length);
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	cmd->status = 0;
>  
>  	return rc;
> @@ -143,6 +150,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>  				    unsigned int buf_len)
>  {
>  	struct cxl_mbox_set_lsa *set_lsa;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
>  	if (sizeof(*cmd) > buf_len)
> @@ -161,10 +169,13 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>  		.offset = cpu_to_le32(cmd->in_offset),
>  	};
>  	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_LSA,
> +		.payload_in = set_lsa,
> +		.size_in = struct_size(set_lsa, data, cmd->in_length),
> +	};
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
> -			       struct_size(set_lsa, data, cmd->in_length),
> -			       NULL, 0);
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  
>  	/*
>  	 * Set "firmware" status (4-packed bytes at the end of the input
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index ebb78b8944f5..4ad4bda2d18e 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -19,11 +19,17 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  	struct cxl_get_security_output {
>  		__le32 flags;
>  	} out;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	u32 sec_out;
>  	int rc;
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
> -			       &out, sizeof(out));
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
> +		.size_out = sizeof(out),
> +		.payload_out = &out,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0)
>  		return 0;
>  
> @@ -62,17 +68,23 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_set_pass set_pass;
> -	int rc;
>  
> -	set_pass.type = ptype == NVDIMM_MASTER ?
> -		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
> +	set_pass = (struct cxl_set_pass) {
> +		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
> +						 CXL_PMEM_SEC_PASS_USER,
> +	};

Extra change?  But ok.

>  	memcpy(set_pass.old_pass, old_data->data, NVDIMM_PASSPHRASE_LEN);
>  	memcpy(set_pass.new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
> -			       &set_pass, sizeof(set_pass), NULL, 0);
> -	return rc;
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_PASSPHRASE,
> +		.size_in = sizeof(set_pass),
> +		.payload_in = &set_pass,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  }
>  
>  static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -83,15 +95,21 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_disable_pass dis_pass;
> -	int rc;
> +	struct cxl_mbox_cmd mbox_cmd;
>  
> -	dis_pass.type = ptype == NVDIMM_MASTER ?
> -		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
> +	dis_pass = (struct cxl_disable_pass) {
> +		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
> +						 CXL_PMEM_SEC_PASS_USER,
> +	};

ditto

Ira

>  	memcpy(dis_pass.pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
>  
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
> -			       &dis_pass, sizeof(dis_pass), NULL, 0);
> -	return rc;
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_DISABLE_PASSPHRASE,
> +		.size_in = sizeof(dis_pass),
> +		.payload_in = &dis_pass,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -111,8 +129,11 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_cmd mbox_cmd = {
> +		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
> +	};
>  
> -	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY, NULL, 0, NULL, 0);
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
> @@ -122,11 +143,17 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	u8 pass[NVDIMM_PASSPHRASE_LEN];
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
>  	memcpy(pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_UNLOCK,
> -			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_UNLOCK,
> +		.size_in = NVDIMM_PASSPHRASE_LEN,
> +		.payload_in = pass,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -140,14 +167,22 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_pass_erase erase;
>  	int rc;
>  
> -	erase.type = ptype == NVDIMM_MASTER ?
> -		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
> +	erase = (struct cxl_pass_erase) {
> +		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
> +						 CXL_PMEM_SEC_PASS_USER,
> +	};
>  	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
> -	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
> -			       &erase, sizeof(erase), NULL, 0);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
> +		.size_in = sizeof(erase),
> +		.payload_in = &erase,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> 
