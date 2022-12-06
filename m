Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EA7C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiLFGhC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFGhB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:37:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE268222BB
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670308619; x=1701844619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tu0U6BIarIVVO2bSvOzhT+VSYVWKIhMf6MncHOrDqv8=;
  b=HDtTWzU3caK1JCeFRUGp+C7kDLVGRrbzKEPJgb1MbNuiLLl8IXu4AOvK
   fLSQP56LCZ05/aOzcLeG3CqtYn5WD/dj6pH7NnGyWJwZ6dY/SjQPKOrvp
   +MC2PyfqMk4qiMYWjmWUIK9KBTblfZszJsVYyoVKhSlzUy5+2VwjqJguH
   yjHvDeygBnmwhQV2iP1OR/Vl6fewpOBReEFs8+ojl9mB4q8vzg5jv6WtA
   FUIF4N9YJMO3WOZcEro4QM4twGEUVRiOBMfJO2SCTxHftGZJ2JhybmCMY
   ekuAlZ0Z0HLheWQ11S/5r4KD+Dn1daRJS8JLxg/+0WEygwMSVyZNEECoq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317690454"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317690454"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648221682"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648221682"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 22:36:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:36:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:36:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:36:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhXpgUkT9E92AgapE55tjzBjWeRKbHYPmMoxLBM/8zY94MN9UCZn7LAZI4jTrSgLIztKg6JXc2kFyB/+U5GOsvt7GprWLsssI7rtNbf36ewtKDrNTvZS6HPeaoNDZlHDVPGWjTlofzIZ9O+f57CVgWmn1xEcOuJ2DEcHLOGpEmUEcWT1GluWfoVHfhXNPXQrj9E51jMnT6TCTy3J6VxqUzRy/KrreEHibhJpzRsiWnQ8RAJEAgBL8Ph40n/3vGIKu0wlLeBwDryGjiseuPRqcSLTdK/RSNR+ka58IXd2Nto243MPP7TX4IHhHVkQy2vNA99DnBeUjlOV9GMmWYz2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eddUl2hh31RNocM2Kvezc1qksBd4QgBAF+EkudU+gM=;
 b=Wv1n61YctDKs2MaEPMxCWFZbp8tmV3UV8AGo775ki/IHv1mFOngFFHOmGf2yrmQlFVD4PaCIi/53vfTTaHGTfBx1auK6DQTds934ZIGpUZZYpIxuPbxpXUGCpMIurN5eHExU2AZfjSg1e1i/AQBrV63tvh+eC556kM7hOcIqsHuZZVir2sGg5gnqxRz/8jnZ1LdGTDwsW3erds6SJrefyALhsyRR0VmR5YDejj4auJeUAod1QZI5YnKmThUyRFomds2LtAoXygT6xyrQh82f7HT3tKkM/pS6Xy5a7xB0kHGFkCmwNaTDloGd/hNgVcDiHW6u1a68KPAJZJ5vGcUYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 06:36:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:36:56 +0000
Date:   Mon, 5 Dec 2022 22:36:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 3/4] cxl/mbox: Add variable output size validation for
 internal commands
Message-ID: <Y47jBa0gBSx151XN@iweiny-desk3>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4ec384-31be-4dad-49b6-08dad75444f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Uox0eYhRlflku73v4vdByao3ob2EvOn0L1gzgwNEOaK3EgR+Jy/cpcGP7FZy6ovRSfJElUfNhYlgy8srUHgI7FxKuiy/RmIv257/Gpz2N1GxiQcnLVBuxq9UrNlaGjXXY/C1hYNm+vBpk3zcuW9MeP5gnn2C38fXpgdjiXlOcnNnOcPmmpvX5q7Vw6HQoB8BW+yLJVZEqZ2HmiFIWRQtmyn444XXmDKdoe8VwMiNiBSXVtbCFucfUAcILUQR39pB+tg973D6WT5Ux1m51C8/n5/jp/tv0N1EvPjaSHW6qI/p+FJCz7PGKi4sG2iXspFGSljFqOJ5YO3YOjB2Zft7hI0In0vIdkNF9bIpD+V/pL8T64QJnfpUN8LjsCZquQ8yZoHU+0P9l5XCswU1RRZsiNtHrHAVBt4iofejciHZuRE2J/PdlvUDmK257R9zBDGlbsqWiNpUBaTeg7IlNMKRxf2z+kyfvva+va+dBTtZLx8i5OXwMqUwPYOuL7hJwmiDI38ASR2CIODInAnCcF6/fwuAGqT4kbkSxJ/vzYhBvqTuxD9vuFsFGtoM0QpCkacGZ+PKYVqBraDCXw3oaG22nNQd838rKbFCX7fiETEMWwWWFq3La5M9ngw071lXZN5i2Y3voDtT/ONefUAkSEqzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(66899015)(5660300002)(82960400001)(86362001)(8936002)(44832011)(2906002)(4326008)(6862004)(41300700001)(83380400001)(6486002)(66476007)(316002)(6636002)(66946007)(66556008)(38100700002)(33716001)(8676002)(6666004)(107886003)(6512007)(186003)(6506007)(26005)(9686003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sk2/t+Xk2QjrKG349tjtZJR8yPa6NXWhuHVMaORXgdwhJ9zu4Skmc1pLEZqI?=
 =?us-ascii?Q?W7tO9PEA4Sv93JRZP+hhxGBywfPICYTprxxYRG+dHU+x/f4Q4O2dRTydB/AA?=
 =?us-ascii?Q?sDJ58FIU0Lao1VPd6p1J3kax7RBlHOUT4/jH6J2kUGiXGMRx13UvssQVVHRx?=
 =?us-ascii?Q?YZgQwQ5GwARYuszXEKBwwhQ/n+WosDVy3aupUXtms292nbaCMZ4wBWPxgKdk?=
 =?us-ascii?Q?ju2YrugNpKFFFTURrjZF4Nq8nftHvtcyP+W0w//adlRnW8mjIM2IAqfdTbLQ?=
 =?us-ascii?Q?6op9ZiStTXKuxeDKeSn9OY9OmzRxrXFFOutHzQRWUtdEczIojJjcAYEfWJci?=
 =?us-ascii?Q?bydhnZNAPJC4VPhMjTV8APegnR0YYVvJfOX4nkNp8Uwp22YWYatMgmLgZse5?=
 =?us-ascii?Q?exH34NC0fSdXfl89we3peNXhlsDfARzd/2ECgKLhd5/zdEVuvnd490zNeS0P?=
 =?us-ascii?Q?7dNBf6sp1uJwm4KTvJDlIJDXMiRvUB9kdvIC/9eTn3Naj17JhxMv8zMurmYq?=
 =?us-ascii?Q?ilUBPMv33+vieHm9MVP7IQJp4fsXxSUfCJeyihqaSwVWEprmaV2xxIrb/mSr?=
 =?us-ascii?Q?0Q0aad/w9DJ/+LBHLpYzknw+Vn/dmsoNhhO/aJCIJuqp2Ud7ExaGHq5ROkB4?=
 =?us-ascii?Q?OTT5/C+lbHMBjMtC99i1qyZsibqobv6KJZuzGd3DJF+ZCst6ziieofDs+ZBo?=
 =?us-ascii?Q?aK+PZdQCBZVr4FwYli4JcyGjVcCU5Np5tGwrZadWndfZI09vSnSVFoYk/Uc1?=
 =?us-ascii?Q?BboJqGkyrJq1q4f+SIu8PkOnei7x5fAjwkti5svpgsunSOcrPXyVVZx5LRgu?=
 =?us-ascii?Q?tQo8+NLrCgy9J/SzXejMebmYjDzCUnVyj/JhueFMMPyAHz9rBjMN4MV3XHdk?=
 =?us-ascii?Q?hBnvD3dcxnu2owWyr4Fab+HSCiWw/1f/uzGeHvt0d6gmdEfIu/EElEtwsoWk?=
 =?us-ascii?Q?24OLecadfo8v2+JdFZguGq8T+uTJ4DhBozQrG5LUBDRzodE3gGVxM3Jefbe6?=
 =?us-ascii?Q?TiSgKkCDIuTUSoZNh4veu5lv5vJjx0XjT+/pbq6h6BA6ahG8eYWvC6MGpV3V?=
 =?us-ascii?Q?eqqdFabR+4cIpndQ9WLMNz2yFWF+ttpUccv1T1jeiAUyvZAY0LuQOQMHUuzE?=
 =?us-ascii?Q?UEHYVxouOSL62XQZe96bqKX0c/yKN3ovRoa4+f0kGFjgKm9I/clCTn0kQ3LG?=
 =?us-ascii?Q?UpkhCcaMt/tp2y4dfINV3lwrLsng7UzQ9b5tyxN5GsQhoSqOPAKtIbwHI43h?=
 =?us-ascii?Q?vv8YsFPqdqPY+7gRQL+moY7yjoBhFls1NhTYdeM8MTot/U3sRLuDK7eQ5NhR?=
 =?us-ascii?Q?LlZAw46qSW0J5DDrYkp4Izq1HjKPi1pSO495b8aDLhMvYEE+7S2RVWFlT4qy?=
 =?us-ascii?Q?yJmxGC5SMyqf3i71vs2cAvrt3zl6mKJzCuqkKa+fBkpcSfKLxJykbiK4/Z+Y?=
 =?us-ascii?Q?Jh5dBoeax1QBvRf1gDaqGTbL1d+BrVd4s4nCa1n5FB9KZvx4X2e7SoYK+I4M?=
 =?us-ascii?Q?UlcZYE7qb3WQe3y1tul7iqHlCfKzslBrJWAyzVOjrFnsTdhR3k5/sliX8ZDb?=
 =?us-ascii?Q?jPGd06sZHWImGeP3CyeBsuoilJwDamrJwQE7IAFa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4ec384-31be-4dad-49b6-08dad75444f3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:36:56.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psY1UXlVinCffmeJ+gu7xQ3i9kQ8e2eou/SfaoL0D5vJ48BXj+I5F6kAVMNrsTrb6VYTIRGf8RQ4jvkbLzylfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:22:39PM -0800, Dan Williams wrote:
> cxl_internal_send_cmd() skips output size validation for variable output
> commands which is not ideal. Most of the time internal usages want to
> fail if the output size does not match what was requested. For other
> commands where the caller cannot predict the size there is usually a
> a header that conveys how much vaild data is in the payload. For those
> cases add @min_out as a parameter to specify what the minimum response
> payload needs to be for the caller to parse the rest of the payload.
> 
> In this patch only Get Supported Logs has that behavior, but going
> forward records retrieval commands like Get Poison List and Get Event
> Records can use @min_out to retrieve a variable amount of records.
> 
> Critically, this validation scheme skips the needs to interrogate the

					       need

> cxl_mem_commands array which in turn frees up the implementation to
> support internal command enabling without also enabling external / user
> commands.
> 

Minor comment below.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c |   23 ++++++++++++++---------
>  drivers/cxl/cxlmem.h    |    2 ++
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ed451ca60ce5..c36a3589377a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -166,9 +166,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  			  struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	const struct cxl_mem_command *cmd =
> -		cxl_mem_find_command(mbox_cmd->opcode);
> -	size_t out_size;
> +	size_t out_size, min_out;
>  	int rc;
>  
>  	if (mbox_cmd->size_in > cxlds->payload_size ||
> @@ -176,6 +174,7 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  		return -E2BIG;
>  
>  	out_size = mbox_cmd->size_out;
> +	min_out = mbox_cmd->min_out;
>  	rc = cxlds->mbox_send(cxlds, mbox_cmd);
>  	if (rc)
>  		return rc;
> @@ -183,14 +182,18 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
>  		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>  
> +	if (!out_size)

	if (out_size == 0)
	???

> +		return 0;
> +
>  	/*
> -	 * Variable sized commands can't be validated and so it's up to the
> -	 * caller to do that if they wish.
> +	 * Variable sized output needs to at least satisfy the caller's
> +	 * minimum if not the fully requested size.
>  	 */
> -	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
> -		if (mbox_cmd->size_out != out_size)
> -			return -EIO;
> -	}
> +	if (min_out == 0)

I prefer this logic but NIT is that they are both used.

Ira

> +		min_out = out_size;
> +
> +	if (mbox_cmd->size_out < min_out)
> +		return -EIO;
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
> @@ -635,6 +638,8 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
>  		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
>  		.size_out = cxlds->payload_size,
>  		.payload_out = ret,
> +		/* At least the record number field must be valid */
> +		.min_out = 2,
>  	};
>  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0) {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c447577f5ad5..ab138004f644 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -101,6 +101,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   *            outputs commands this is always expected to be deterministic. For
>   *            variable sized output commands, it tells the exact number of bytes
>   *            written.
> + * @min_out: (input) internal command output payload size validation
>   * @return_code: (output) Error code returned from hardware.
>   *
>   * This is the primary mechanism used to send commands to the hardware.
> @@ -115,6 +116,7 @@ struct cxl_mbox_cmd {
>  	void *payload_out;
>  	size_t size_in;
>  	size_t size_out;
> +	size_t min_out;
>  	u16 return_code;
>  };
>  
> 
