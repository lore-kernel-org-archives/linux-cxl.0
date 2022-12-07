Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B3C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 02:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGCc7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGCc6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 21:32:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363143D90C
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 18:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670380378; x=1701916378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KRDaNertalGAHcpMDsJwoP+wQSaIhNa56uwyMx58FqM=;
  b=mA8gAZ85synmwgu0DdnUtJ1es1gP3TBFgikc200lCC3DNrfBEhbGbEzz
   d+j5YQfhVxQL1lJK1r48wFfytKRSYAf8KTBigq6N5XRJyxr3eGu6U+Bzl
   irI9WsFU7LL8zEbZgzCC6HK82zN/RzKvvMKTgmarSxjaD4KmUezHcOezk
   74VnUO+W/blVWXQ9qUCKFe1oggfgznNT1dkaY2Z06HGw/7bi9DpsSzi+L
   jBJtrEpGTixsyxOecQZ4y7DGFdNJxJdpFicLjFq15DiFkrBqK91Tv8ScL
   DaRenvZQgmo8sraWhsYyD5U9yk3cAOQic70xkXaEWyluj5TLgI4zvcLCM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="314429553"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="314429553"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 18:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="646439327"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="646439327"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2022 18:32:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:32:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 18:32:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 18:32:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlXAyRxChuu7WoQwnhO4iyk5ztLWGq2yLkxlYaZdlMP9ftmJ6sdCmD76400xUxwXyQRKwUHKLwdWSgwMHginjYVW+8pCTuQbt73uAMWiJQPVyKrM51mqrtYkVB/cUQkn0inuvsZBTOeBNoweMForWhxaSNyML24EZ6Ijv1ZlD4w5NReAm/dEpZQeLnHY++xewouKtIO+8Z5jssxoJN+y/l9syFcwVnl2vRh5A0m4OuZoSinf6XXKCx6nERJqiW4AHyeN8LVBtL4RtXqsD3x/+n+HaNBRvDkHRrKgo4lBMoFFKh6umIur+QtBSVtl9iPxDtzQ97rcnh1eVKpSZ16PUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL4rC/Gq4wC+/VMdukD442E7yIXTkbVCmx8uiUWI4ag=;
 b=ZPO1GiFdVDX+B4/pnvWAfP4VBVOH2WFyvKLHHJoy22u54u6I9NFOq/hJAmgrWTrD2Hd/7pD/ZkwDufkKBlDNucDpjzSiWj8fQiNdV1hq+rJvwDzUnbmMKtJz9XVM393eb46L4TI65rpGadUjVTpzsWcnw6kf6jlgTDxm+sqqa2iQmgGVN4ahtAJlpqe//5sLl/0G9tdhzLrkrJxjKSjAge1upDl03tT4/v7+H3Itq1AOroQOBRXK7p6BC1tqli5mIgBSez2D/Z7wMBJdVkisuOhx7Cq6TlOHG5s2edCGpFRdvPKZ4NTSSyeLOyuDADujnIedlpKcODE3lQs8+cFk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6674.namprd11.prod.outlook.com
 (2603:10b6:510:1ac::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:32:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:32:55 +0000
Date:   Tue, 6 Dec 2022 18:32:52 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 3/3] tools/testing/cxl: Add "Secure Erase" opcode support
Message-ID: <638ffb544ea9e_3cbe02944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221206011501.464916-4-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f1935d-83eb-410f-dcf6-08dad7fb5883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI+aCcIb9KJtueOnrlH1W6SYgGGZenL+6l6mpzQJYrpe+dlvj7CktCSp2ufteoXkvi+VPcr+8ChaupSYOWlldA5GBHJljYZdVL+7PbR4w4iQ+cLBgPPHbCPxy80JE3rZB9mMaFn452JzhdpGYGys1q/gat6/ia7QNLv6cLOEDJbRWNUXlGS0K70Fml1BjfvFc8N1JdRQyHZQhXbq3CAaSrDlYeqelzA1452nCIEvd830mgE/UDUzDUftw24/BYPmVaVcBAB6f7rjrsgBFvihJUsJSzRHulET7L8GFbhqPgY9jJsvwOeZIaYvAK4RJQ9M2jf8Q/sctCHb2pTpeQwa8i8vx3cYEDbbKllcQb66OVXWr2lZxaLGtWIjDQeHwdCOvi9Jmyg9p0V6WT3unSjoMJu827Fqppm3u/aiGUj16gErqxn7UbXifM1nHvqLetxT9ShBghDIpz4RcM8n/UoWglEYDUMiFg8zOOdAJlGXqNvVcWU2WsvTd40zWNmFAzUPJLYtWzbWvVnIE0ilr1IfSodGPbNTif7zYDwRM9wqxrS2/9izo2QNe6J5LLm3EXD6aSAjvdXHxDRHHNPBh/1GcfgnciaPOM7Puh0xzEjWLm2qtA/71rLPGgAO/TPJLDokLVx2E7Y8CfKBoMkcBarOGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(316002)(6486002)(8676002)(478600001)(6666004)(86362001)(66476007)(38100700002)(83380400001)(4326008)(66946007)(82960400001)(66556008)(2906002)(8936002)(5660300002)(41300700001)(186003)(6506007)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mt6b3C+p/AVpbQOao0IybwNN6ft5PDjEMxt3GdS/b53TAFV1m97ZJ7Bx1zjH?=
 =?us-ascii?Q?bk8gS+lnjONL9kiJYh4uv/wclTOz4ZgpsK/hPSt3BimmdwXIdfeajeHH8as7?=
 =?us-ascii?Q?1Da2u4wwKLQ4AJ33ShTY/sn9alS9wj0xpfH4EZzfZAJQ2z/cGrqsPYUKRfRh?=
 =?us-ascii?Q?luuzNKQkp89PeaiCWg57logNmDucy2UpFEeP0NP5c6bCXKHlge9VXwN+ZkEf?=
 =?us-ascii?Q?f2q1+qjNAgnvM+IzFWJTLXjVGSxgGmaLz42U/o7dZAaA5wPDa1OumPut68Z1?=
 =?us-ascii?Q?vvnON2Vm9fKXwBibMIgo7rxQOFI5FrUiFOaSUD0kMJ53FWH2lQSWRL22NyBW?=
 =?us-ascii?Q?4G6FqaqPDW5aEC+b+zMTrMMQyuqgp2TFbXPOzP7MBE25KvmksWzTYYCJaupb?=
 =?us-ascii?Q?p+ev4BEOW8XwhBqeYaJF+TtYFUr19JqnZzXT+bf8F5M4rZ/0iiYfjSZqSDWy?=
 =?us-ascii?Q?nrFRUlnfXWECLACRxuhN53T0k7UOzMPE6K6vpF372cd0hees4gS7YsrO4B0S?=
 =?us-ascii?Q?k3Wg0wmdfBCMIHl1aSXMO9pQMVchNc8oeqk/ZX4R8ta3As8Bp9EkeRTzpLk2?=
 =?us-ascii?Q?rCQ84S1FDpraVYvC8fTZRO6iTyH/1IWQPjmbbFZHv+JumwG5QXakx2Kz0oQv?=
 =?us-ascii?Q?8ygeEN77P0iBBDPMqc8w9fyvz/zRDfIghALFTYIcmA45rnH+tGybFmMHrEXx?=
 =?us-ascii?Q?A+zGenqRbjPcSNk7Y0tBr44HExxO/xZ9VWoe100BK43OgbgH0QG3aPKLab/4?=
 =?us-ascii?Q?8phQh81T1C8/zHmTcr5ZnJuFHSaii2cHa78q3N73XgQqsZkD9ty+g1EFRlIA?=
 =?us-ascii?Q?7L5y5Hfc9gyf5bwVfrI72aeElj7Rm2B0RYiu6zBru8pHKLav7UTMd42C/G+y?=
 =?us-ascii?Q?Pv2A1+ArQjKY2cWfvfA4UOZ86IIUl1cmXgSNL1YoKMyXqQl5KgKLsea+Dt0x?=
 =?us-ascii?Q?r8UouwK3FrKCihiFjH34fAMM7G6tkqppCEnjy0W4fsgNMOdgvrlJxH3jdDCo?=
 =?us-ascii?Q?NUKu0stNbJHEIm2hIdTc9ANIELjYinRIiLtOuag90A4lB87dQmaYR8X7DyvM?=
 =?us-ascii?Q?hW5VOWLczJtBGmVKEUD9JCeUS2FIROd1UIMxBVL7Js1+rhOPlmnx/hjf6wnq?=
 =?us-ascii?Q?rm5b/7Kp8VTtIC4F/v1jRZ1/1B7gvkNi0rUQBRX0q7newKgOplAu/2w4b5D2?=
 =?us-ascii?Q?2t/XkodTXfmjSreJuV5+UqzJ4litxzOCPYjRJG5KvM85efFPo5G2neYlQmxZ?=
 =?us-ascii?Q?m8o3vIRK8lpX5A/mZvtYKmvCronO8ShumYuSZynSAYQWblWcTWoThDKzEBjb?=
 =?us-ascii?Q?Gt/0zWfhI4YvVbJLQIwnaOLLMlJZV3bkfFhcv80LvPtrkNl6UwV61tqBpR8I?=
 =?us-ascii?Q?XrfbU5k1xqVSiQUHwjIUhdaVwkJCnrbeCnvr+hDlN7ANRsEeQm3jC2ATKN4u?=
 =?us-ascii?Q?JHoUSQINhJmxvKsPKGnt3iHtjl3LmjHD0Ptkn+4ZStPCmvQJUSx7Ofz5rnpX?=
 =?us-ascii?Q?4EtVB5hs6q6ds3X1nUSPWPZprLeyeKfH3nehIfPZ+jZAztmwQYynlCmZYvOz?=
 =?us-ascii?Q?bBOmg5dfMRuuJhu6s+kMZVSiq1ivwvCO0BB8McAGXqn/yovpLJ+K1ko/4qE/?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1935d-83eb-410f-dcf6-08dad7fb5883
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:32:54.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLFycI/sgyTvrwpPvxnqTtrBJicVCKihHVlvaHlU3koqoRUfZJVJQWQDZUtp7fBNwoYog8A7lJ7ztQIOvv+KjezoKZUFUtf5kDtTvou1GrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Add support to emulate a CXL mem device support the "Secure Erase"
> operation.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  tools/testing/cxl/test/mem.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 35d9ad04e0d6..0f3101f65901 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -149,6 +149,30 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +static int mock_secure_erase(struct cxl_dev_state *cxlds,
> +			     struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_platdata(cxlds->dev);
> +
> +	if (cmd->size_in != 0)
> +		return -EINVAL;
> +
> +	if (cmd->size_out != 0)
> +		return -EINVAL;
> +
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mock_get_security_state(struct cxl_dev_state *cxlds,
>  				   struct cxl_mbox_cmd *cmd)
>  {
> @@ -567,6 +591,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_HEALTH_INFO:
>  		rc = mock_health_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_SECURE_ERASE:
> +		rc = mock_secure_erase(cxlds, cmd);
> +		break;

Would be nice to have a sanitize mock that goes to sleep for 10 seconds
to test how command queueing is handled.

>  	case CXL_MBOX_OP_GET_SECURITY_STATE:
>  		rc = mock_get_security_state(cxlds, cmd);
>  		break;
> -- 
> 2.38.1
> 


