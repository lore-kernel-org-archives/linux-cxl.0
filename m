Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F3C636D4
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Feb 2023 04:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBOEUY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 23:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBOETq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 23:19:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08084692
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 20:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676434673; x=1707970673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fhWxlu23Lb4acCxS18qVIa48q5PskFWR/+eYbAXwggk=;
  b=nGdYw/ZLLR9PcZhfxLcpJXfw8Wo5JycljGyRLYOunis7uB+UWCuKqKho
   TlPKvkZCDyqVDkeDYjqiZKwRL4v9IjcwlGLCZ0i1+xumzoVGy+1uBOlmC
   Ol3mG+jEDFE6CE63owZd9MTeQEZS3wXgRn3cmkuYvV+UZ4VAQ96IKbQyL
   JuxACvNcAq80JLYMVlFG2iHn/5dVsOjkIcQr3eUFb6LTK2CaDboGG/ma6
   NQCsJVlai24K/fSjvyLOfgf+ONIfseZWXkkql2r27Hblnr3UgwtvrmCId
   rG6fZJHthywr3tbIgsh0zh4bHqvxj/uEfEKNlVpfZAeZq0YSbr2YHYldp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310971851"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="310971851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662790583"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="662790583"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2023 20:17:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 20:17:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 20:17:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 20:17:37 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 20:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrySv/A/VN6iQABBxdWINr4ok+wj9pvlDAZyZe6OR4KlTHvNH+XYuo5hfjG/KYnFroWGBdI6ZeVuWvoE97K0PNqJTLaWHlzoOcKPsEV/PukjrLBImm4I+yRb5GvRD9jsPjj6EvGjSVMaj6YOcTOsyapCUeSXgDKiUonFPT9zViheLm9KCTO01kzvRdyKs3y37QxEFOWTiw4pkeBSNAPAqrnr+mzE0oH/fd8itccZ5WKruBOe/YV/N3eVrBYDrF+dTTJ9GNQXal7LKozAd+LvVjy93ya/NsHEZuGo3PSlCx36PhZul2viZvqpNthk74TTrcRQsbARHon12sZvU3nfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgkvan6TZ91DWHbGAB+8Vkw0bWo9OEtKVb1d/YcqdLw=;
 b=VyBJ98YAbo8LVEtFhN+SZCVK7bj+IoILnkx6u8yXSFeiY6EbEH0wAP73jUs2K1joD0dVO0JHNU+ISKto6CGsXCaXZHRoasTq0RjYxozCXzDGMiMMb3EG1hkK8JDNlpCiDttc8q3mEK18X6ntURAIAJvlsImljRMPztzPSMxihDxwIKbjYdY6TdwzBbSxuSA0EUsaHByRUet1yus7TYENCnVa8NvR3qCwCLbJ50c6Gx+rvNlOOc5Qgzh0thW+BRruKzzkr9wpNJulPN+N24uvvZN2GYWlhDApnb+XR4ghyfribX4zYHzJKuePur3DpirnRy4TAWmheMaY6R7w0A2zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 04:17:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%8]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 04:17:34 +0000
Date:   Tue, 14 Feb 2023 20:17:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [RFC PATCH v2 1/4] cxl/mbox: Use local cxl_device_state variable
Message-ID: <63ec5cdba00d_18bf5929480@iweiny-mobl.notmuch>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
 <20221025104243.20836-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025104243.20836-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8b8392-0693-4a98-2b01-08db0f0b901f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMRlcEZmHqTkbbO7d3/Zrcb1DM0dIwPtn5zpZxMLGFnlQAyC7PoNGfdv8QjrgAC/c8zfPwJgMS4LnhTtdo4820NBqoDDiE3jML5/3Wf7WvwSeFflYXf8ge0SIWpwZvbV8PR3i3UxTfyfe3hH0vYQhER9QswsO9HARSz3Rp32dX7u3guPcMbFJBEW0qPKmTcY9wqliXO5YoH+yeUuksV/pUuUtaeq20P3Blp3sMOQYXC75lJ9SKmz148QVu0yxt0D7rL6acH9CpnP8KPuC0QTDtD2KUzViEPHfcjX9FD1cEWnmMbMyQ04B5+b6Ibnmj6vbQuyMuKC0OBwLkMNTivV77ki2GwoCvhbkE1QqCKnIU4+DLOU3KJTfcpRVoZJSJ1/URLk2+8w2d8PzB8GPsIbuL5jzUdn/nFYcguF/VuxYSZjrMMNKF6ZN6AmoLifv2zkAwdb9rhXPAaQ5l7kzZBAGomFm2KWubLGHRF0J4ko6LZ4vGSYICUaiXnDKXNRFPkjW6MPlxBsfGJ4l8pNuZN54mM2MIfqVaPB6o+Yb+olAeWnWGlAuuyFKHu4PBZT0kyTG2bCaGB/VQhXw9oMl7GapLgUgxn8UxpvoSM18oi4uXDGoV1h2QJM/ZAI7j6nLjT8XKrlvADyOKO6W7XTpI5gwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(186003)(26005)(6512007)(9686003)(41300700001)(82960400001)(38100700002)(2906002)(6506007)(8936002)(5660300002)(4744005)(6666004)(44832011)(4326008)(86362001)(54906003)(83380400001)(66476007)(66946007)(66556008)(8676002)(478600001)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nh36YiLCAbg7fLxuri/2qSNUfb3hNYnaQVxorCxCyiN+2sxe60zwEUUDjIQT?=
 =?us-ascii?Q?bVQAhAHNnJm2F8CWNW2HtulDm84mLsRyrbZKlo3CQ6DNfYIVA0L1o9dKZeFk?=
 =?us-ascii?Q?qenOhRX6gyceXD+2sKE8ZHWhNRIi+4z0EoRvSsAIlqrZ33kb48qjMcY+dSe4?=
 =?us-ascii?Q?paheqLz2Be6d9WlVIJM4EoXlnExjZ2yPOWyHj6EEKoBgAaan4bKAdZMeK2Cj?=
 =?us-ascii?Q?39dvWSTqNss8tRKdzYHWJv3zuvBBf4bYojArTdlMy6CTbFPbhmXKqy+sh4dp?=
 =?us-ascii?Q?595Nq4Rba/1suQwFpsdN2glR5h/XBryqn1s7IZmhhJS9Km4/T7vDaVkWU52q?=
 =?us-ascii?Q?i648PB2vkmLbfGLe0URjehkSxRl8Mseqq87G69rQkSir8SKBLVOBMcMg8DZ6?=
 =?us-ascii?Q?Yp1KynUr38MbrnkzO4b4gSNywzW8Cy1pVoW2OJk5nsocJP52w2svmBNIUtgH?=
 =?us-ascii?Q?6Dee8I5VQQe4TxGFTwEIaK6qJTOCrLlRBKDzGZaB0sydb7yL1SlDxaJFJV/h?=
 =?us-ascii?Q?uJXFex3jmAV1W8vESr5PvGeN4tndoeg7IlQUp9mD4RlMnUFXzbiaye8SSoXv?=
 =?us-ascii?Q?i6QOdXWLMRPWv2nOUIIwODT/w4X+QVUixsdcfDD3TRYxsOFeY3em3HIonomw?=
 =?us-ascii?Q?hMFUXNJ7YHGf5qdt7yD6btXcivz8E/IBibV39/Cd4yEPWZPx8hhf5XCJjSEG?=
 =?us-ascii?Q?GvN9dUEYUhRJaxOhEu4LG5ZrJsM5wrIVF2emoSwXTrO1M1fIrM+4bUj7Sg0Z?=
 =?us-ascii?Q?pxxD/rReun7JcukSYlipV9sWTVlAUWz9ARRxoWZ0RU4aTxxCgHFIw/2Fh32x?=
 =?us-ascii?Q?YxfY+9NsmMAgEbu+JZEXaY6qW7xKWEVntZ5SOpoFwD5dXk2GCw4BPY013f5H?=
 =?us-ascii?Q?mB8FZWmskE+ZLv/WrTuWQbA9/fUFy9PA8DxpUnxlm4j6qJjktuQwftQOTjFJ?=
 =?us-ascii?Q?jbUxUUebM2aHbyqLbeKk/VNc3Tw16Owy5DTqWjDM/FvCVdq/Vc6ZnyVmx4wh?=
 =?us-ascii?Q?VQJ1mF1sak7V39Vy1sFAjYH5XylljNKIv0p65o3CFqYhb28EinZEu3I09w1Y?=
 =?us-ascii?Q?zvm9mkW91ROyh+BZfWNx04bYSZ8FcMib22LsOgA6aXyWapD56f3MgTzdZvYL?=
 =?us-ascii?Q?kAJkOTo5yzh+WiDr8yF3QmPrnQoTyv942YEUiDaXOWxLRm2717Zm6aqOz4qy?=
 =?us-ascii?Q?LodXk9NbSJRO3PAXG/5S7wmWO9pcwQj1JEHIIAP51Ty45lkNuUcY/2FOxEgx?=
 =?us-ascii?Q?9lBo+mfcsyW2quEoQnQhAfFKsh5Xf+VTejtn2bHB998R/sJ+aJfq/fnzxivX?=
 =?us-ascii?Q?rs1rppSwRd4nVT7G0pZL78I6ZCPootjTkTYCir2CyIrZiwY2ajRUYgPA7aZW?=
 =?us-ascii?Q?jnSeLy14+fmC7xD2d97JhJrYL6coskqo6EX7aKO66NjZq1Upvh8iDcytCEB5?=
 =?us-ascii?Q?bm/QTkiWAii1CJGNTcm6kkkEzXbQR452fdBBEHLoqUZywzxDAVIb/j+9m1SS?=
 =?us-ascii?Q?g5TNJR8xlPnUUXxwKsTYkV+nLWSAm8crBAufGqlNbCbe2QpcHABN3Ym95UvU?=
 =?us-ascii?Q?+vvBUJhwrYnl+cnC6EpzboZv0z1xpOBXcWN5oswn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b8392-0693-4a98-2b01-08db0f0b901f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 04:17:34.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9x8hV+O7Wc/gMIJHljtIiF0es2Ct/DA/ruh3rvYCnQ8YhCx4uCtPTFO6Yt1AhP8xqMO/hP7Im3Hjqj9UqdVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Given we have cxlds as a local variable, use that rather than
> getting it again from cxlmd.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not sure if this ever got sent for real inclusion but it does not look
like it landed.  So FWIW:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0c90f13870a4..dd9e0aac37ae 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -539,7 +539,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	if (copy_from_user(&send, s, sizeof(send)))
>  		return -EFAULT;
>  
> -	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
> +	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlds, &send);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.37.2
> 


