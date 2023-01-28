Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141AEC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 02:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjA1CGx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 21:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CGw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 21:06:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25351B543
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 18:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674871610; x=1706407610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ml2lXaxt6pk9SMZVgvCho3LtH949fnHxStOwem2b2nA=;
  b=VwBtm6vER8NRsU6W/47RofnNq46ATuXfZOp+hPOF/qHJPinhX7bzA3et
   6UpuauoCgz6aXSg+/mMLk/TL3QsWsiKjiBMpByyONQx8iPSE/ueIqiSDQ
   MXVb9UX1tZDVJSNfNMyLQiWbjzeiiIwGqi7OHJnIYOPTgREMBQmXELV7P
   0g1U1KZA69VDGDGma++UMsMgMNTob87tWWidm7wHi84mh3Gqz+iaF5LSo
   qP+Zw88vCHb2dc9J+4u3NeEdWLR1VMXUmILhedeDboJJGMslxul9tSFmm
   hrZAIlb1Iez9eND/fZ9puCJYe+1dnEet8mUaAiLFMnfvLPtyMrm4S1EPn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310872060"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="310872060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693916650"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="693916650"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 18:06:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:06:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:06:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 18:06:49 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 18:06:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4H4501paOJT2ohvOnCDKK7ZX9+t47DdK3C+5Ic22qn7zOaFDURTz8Tl/ny0lLeHbnIYwiE5FYzMuHsMXdfSHHad0mPwQucbdcNaDcoQpyljMTtI3ndzTgPwO/42rbBLRWRdDWRBaeDm0+RiETFF2ihYJ/Ro7aacwTq7fly6tc1xu0RFkoviN1DWQHpcOeQz5xHDy3BwJm3jzKMFfzU5cc2GHkLjbP5bQO8d25U1M8PAWsWcHU+7013uOzgoJUCFmIjDlT4ths5MCDA8zN/m+K7M44zmTeBvsk0h275CO1TRz5YMQAnNugv7Zj3j3z2tpayQE6Nc5Jw3r6eOFf8a2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbAeX9ekg+CDQodTjytkV5puTzOZ3/s2PxFvWMVYEUo=;
 b=bsKeFbVPTXPPBsqUZqv99JVE12/pgfCSHHQVMsW8nozH9awhHBVhFAND6sm92P+JS6IjOU5ZpP8yqCzPAnaKljOULZbxCzeSH0LiugxLufW4iOdbpBCpVvXC0rSzRXDUwjT0Od3Y5CKWnxNrWWz4PQnp8jLQME8kl+M9wopwyOh+FujGIDRt0r1sUyPNrlS8fGVtC/qr7hZVqyeeWKXOJ9wj6xQTGlALPSbHGqXbYwj7mVQoIkXPU/5u7v1i0xKoxE+XDDS2kgowrSaZZYWXlS32qeCcaUH+gFhVN4sQOU3xp2JSReeQmziCyJQO3e+SkqKUCp3XJjTAy1I/UNRjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 02:06:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 02:06:45 +0000
Date:   Fri, 27 Jan 2023 18:06:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, "Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <63d483332ff46_3a36e52942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 103a12f1-5229-4aee-d3a7-08db00d44e49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DetU24FHegSonCCmmO4LbXriYD4PQM1HUeOBlZtfJrVrw/mupW5jh+MwHoFbnGZCi+iibihM4j63SBURS0sUaIvqN2Nshd9044F8+I8AKTvhW0m6jZ5mWShABALga5TTCCVvs+jfQ+LxT6HNWMEZ452K/IA/wTYZg3QFJWxw8acjX49LPcqQCWoIIlFikQcj+D3u2XyoN9UMAvF0WMqHspn4Fdb5chpWxIibw1iV1eSsKvC3pxGoxnM9mm6l5olBLqih9GoWMLAZvBp0JMZrVo7R1yzjMV2jDGCZwOSQ8XTvQ/VYYQjtp8PxZtzOR6VI0DUUZC4KcdfiyaZPrLw1hl+Ub6CHpHMv9NoG10yhy/XB/Pg2zX332ORkBItawCZepFlD8P+nhlDvQ6GhmNR2aff80Zs16m5hSxDP0Shw9k1X+D0JVLjLZytJhXw3nNwaeS3G7gQULIcVp0TSR2ZvXFVQPcA1QXrLksFsU/KEWKHOnRBe6rCqffoN95CEZH8FctdGE/AdIStFdALoDXuK+UuttUQu1m5zxYWgfIj8xEEcMKlrcpRdf2tiEsoW+5myvlx9ugxipS908sxMFRN0dnZbl2zlpXuKn76r2xEb3kM5zz8+ZGxSfTFP27Ubio3FP9RsxE9H/C91T8W0HiwFrKmjhvNza0XDaD05dWpTkoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199018)(6486002)(186003)(9686003)(26005)(478600001)(6512007)(966005)(83380400001)(107886003)(316002)(54906003)(41300700001)(8676002)(38100700002)(82960400001)(6506007)(110136005)(8936002)(86362001)(5660300002)(4326008)(66946007)(66556008)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CASIMrnmZkgZn3eSsrpOiONBoH6nN5jEtwJG3ft4arQh3AqlCpi0ZrP4c+td?=
 =?us-ascii?Q?BFjTlsa3HnSOazL4XUjdgyybgGa+/FDdJKrrf5Uk2DhlIQDbaK3nHXG7L5fL?=
 =?us-ascii?Q?jGa/zWUwUlimG6onzSA5MZltntvVik+C8QBBvm6y8e8dSKgctBjMLMSx3b1P?=
 =?us-ascii?Q?5bRyWzxFKmKMWSQpj3s8cK4PVQmXzTdKYayUuIa3yll+vTI1gAM2JLiGG37Z?=
 =?us-ascii?Q?A3t2q6sDqVVM2Pf6Ehb6IqyGuBYzDdzY7meLmHg44oc0HIU1gsCKZD+qOIoq?=
 =?us-ascii?Q?e0QtDjD+MV5r1GFRMKilOikXO3kYokEvh6TzSmSzNSuHkYx76TvkvIopT/td?=
 =?us-ascii?Q?KLXa+EGlhgEkeA0aDNOs0WuU8fzzM31aHH6KijmTgbUUIYTaZiuuk2yXwo3n?=
 =?us-ascii?Q?Aoyzym0eFiUk6WSd9O1XKxNS0nP4R5pULwK4fCkbQKV8dk9lJRQgHzTL4gH2?=
 =?us-ascii?Q?qK7aVIZCtpyJxpx/noeA7S9P80tyv64tIhy1mTbGAKviCkm8Em9cb8kzhUaF?=
 =?us-ascii?Q?FhuC4InX9V+oEQG3K9ZhgwmhyAt9Z/Fu98WHj+ZqXTdK97tRNx1OHy1cvohV?=
 =?us-ascii?Q?SE3jzRXT7SboigV0ucTnNL5rJ1e6i5MaOZLIhMr18SEZwNI4/4a/2h4Mc+J4?=
 =?us-ascii?Q?12bYPIVRQ+Uymj71Lyhsu5nMMQdYzH99+KDeNkfGq9jDXK4hkEVrCxbizXYk?=
 =?us-ascii?Q?RzNsc4OUIeJHb9Fwm78ehEIFwYorma7uH7Ps0oBhgLAFTn0uGfDC5QJaIvOj?=
 =?us-ascii?Q?quVRAffrgekhuRUZ+U6VCrnRKNEYHGUNyrg07zLwgXxgjWAr8KJ6yjlR7WR0?=
 =?us-ascii?Q?ZhUx2uSS0sWjvHXw0asOLLISsMVF3mMtyucIDRl188XMDRabMUopcufzJB6a?=
 =?us-ascii?Q?2/zAMqPWVdahsLnR6InzMwcz9KRgr7XzSvNLRpVZ1PWfmUDK1b1TIL8Nd9ME?=
 =?us-ascii?Q?Dt09pskxLfzoRnkYhxGUlwno20Ld5+GUbFS9TvUU5B3hM2raK0f7Bf8CfYL3?=
 =?us-ascii?Q?A4QgkyQTgGZ+BsX8FZhxj+GksX2RxM6Nbp+0BfD1bo526WWi0QOmZp/rkGaW?=
 =?us-ascii?Q?FwsI074PVD+dUs59zxvswcAl4o/PvbDIRX1YO3mG+PKIlpDBF+/XB046HY0M?=
 =?us-ascii?Q?OMROPPmHUWpNPlmz3FdURP2D8idP3WntRL4eHspqOX9crFokVoAQJ2cI54KJ?=
 =?us-ascii?Q?QBokbH9/EJ4CxCXL8c9GlIGjnaWRqjaLdCUSJAnzO5qP6mmamfhBb6KmmgS2?=
 =?us-ascii?Q?eFJzl6CY8o6PSoI3UxQwBV+jCgNBt3i/khRBc+4meD2tZ9WI2s2P+3EA3ftR?=
 =?us-ascii?Q?qzt2bI7I17pTBXvn5ZNogN7NjF23vb1cQPaosULacrWGCBOPONtWlj0XiEDP?=
 =?us-ascii?Q?DXjRk+pxa9EwI96Ae3I1kbCBCy/OQqS3RJMn2IpVIopPqFdpEEmWQbzDdLEP?=
 =?us-ascii?Q?KkXN9YXn+Lq9OH7XETax/rUaXL8PUG3FTPzfjK1lap9sUJ39SydAEZNZ+nyF?=
 =?us-ascii?Q?K726UPMzY4HZRqgw0dakRxqQM5SRlky7dXUbPI3r95a+A56xYPEZyM3QWX/W?=
 =?us-ascii?Q?hliO+3WFBFCR9i64qjEUZIbOiEBDw6/JZn9E5zDTv/ApsvAahr9kgBKcUruY?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a12f1-5229-4aee-d3a7-08db00d44e49
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:06:45.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoIeA3kn1OAXyLdDbAgf0uWKfv6qU3B7lEqfj0PUFwmeWq8EJYcy9upiWG4uixXpTKgFbFfYD01DtpT/DpBddpfb/8r8t3i6lkmREqG5WSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> It was pointed out that commands not supported by the device or excluded
> by the kernel were being returned in cxl_query_cmd().[1]
> 
> While libcxl correctly handles failing commands, it is more efficient to
> not issue an invalid command in the first place.
> 
> Exclude both kernel exclusive and disabled commands from the list of
> commands returned by cxl_query_cmd().
> 
> [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v2:
> 	New patch
> ---
>  drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a1618b7f01e5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>  	return 0;
>  }
>  
> +/* Return 0 if the cmd id is available for userspace */
> +static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
> +{
> +	/* Check that the command is enabled for hardware */
> +	if (!test_bit(id, cxlds->enabled_cmds))
> +		return -ENOTTY;
> +
> +	/* Check that the command is not claimed for exclusive kernel use */
> +	if (test_bit(id, cxlds->exclusive_cmds))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>  			  const struct cxl_send_command *send_cmd,
>  			  struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
>  	const struct cxl_command_info *info = &c->info;
> +	int rc;
>  
>  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
>  		return -EINVAL;
> @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
>  		return -EINVAL;
>  
> -	/* Check that the command is enabled for hardware */
> -	if (!test_bit(info->id, cxlds->enabled_cmds))
> -		return -ENOTTY;
> -
> -	/* Check that the command is not claimed for exclusive kernel use */
> -	if (test_bit(info->id, cxlds->exclusive_cmds))
> -		return -EBUSY;
> +	rc = cxl_cmd_id_user(info->id, cxlds);
> +	if (rc)
> +		return rc;
>  
>  	/* Check the input buffer is the expected size */
>  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  	 */
>  	cxl_for_each_cmd(cmd) {
>  		const struct cxl_command_info *info = &cmd->info;
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +		int rc;
>  
> -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> -			return -EFAULT;
> +		rc = cxl_cmd_id_user(info->id, cxlds);
> +		if (!rc) {
> +			if (copy_to_user(&q->commands[j++], info,
> +					 sizeof(*info)))
> +				return -EFAULT;
> +		}

I like where this is going, but I think it is still useful to return all
the commands even if they are not enabled or currently exclusive,
especially since that expectation has already shipped.

I also think it is a bug that this command passes kernel internal flags
like CXL_CMD_FLAG_FORCE_ENABLE. So let's declare new flags in
include/uapi/linux/cxl_mem.h starting at BIT(1) and do something like:

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..1ba0e12fd410 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -87,8 +87,10 @@ struct cxl_command_info {
        __u32 id;
 
        __u32 flags;
-#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
-
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(2, 1)
+#define CXL_MEM_COMMAND_FLAG_RESERVED BIT(0)
+#define CXL_MEM_COMMAND_FLAG_ENABLED BIT(1)
+#define CXL_MEM_COMMAND_FLAG_EXCLUSIVE BIT(2)
        __u32 size_in;
        __u32 size_out;
 };
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6ed8e3654939..24469668f1af 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -427,6 +427,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
                  struct cxl_mem_query_commands __user *q)
 {
+       struct cxl_dev_state *cxlds = cxlmd->cxlds;
        struct device *dev = &cxlmd->dev;
        struct cxl_mem_command *cmd;
        u32 n_commands;
@@ -446,9 +447,18 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
         * structures.
         */
        cxl_for_each_cmd(cmd) {
-               const struct cxl_command_info *info = &cmd->info;
+               struct cxl_command_info info = cmd->info;
+
+               /* wipe kernel internal flags */
+               info.flags = 0;
 
-               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+               /* reflect exclusive and enabled */
+               if (test_bit(info.id, cxlds->enabled_cmds))
+                       info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
+               if (test_bit(info.id, cxlds->exclusive_cmds))
+                       info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
+
+               if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
                        return -EFAULT;
 
                if (j == n_commands)
