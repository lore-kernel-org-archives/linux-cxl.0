Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA628219EA
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="albQSHD9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7EB7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697216977; x=1728752977;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=q7Mw9BVOPVoLOhINCgSnE1rZyHljb4zUlWK4frfDS6U=;
  b=albQSHD9ZhIbL2yX2M7vid8eKfAyzD1zAdVvPlo40xx9f08tvWmcyn+E
   klORPoOPzbn7ORkbwTWezueUoDwJeeTxcgqe8Rd9ZG4ZoqcjEKxRB+wRf
   /7Wu+0kc9ICMw3aioYZqaNiTewtNiesc/NTzoru6PVRDDi4O+0FXbzDxB
   NE0DKXp+nMiNUl9RnzB61OzWfMJ4IEJvQmgXOaFpHg2DUn3DAcOZOQYuf
   Bqa+dtYkU9uEXjwiEROjE5OYO8ORcM/hBb5w6H7vcQQKTPKHZvpmpiX6/
   yN2t4v8CMBTg7IIPO6C3vkcJy+MlWMxMxB14s3Jfs3XvoVDhveIOSTEmD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3827639"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3827639"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754766484"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754766484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:09:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:09:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:09:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:09:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHy3/jVGSlrPQrlFoL54ZEqcQjk1Ozxw6TD3z+tB4PfTqx3Fz+f6NZMgiufDqnJso2eITL9iLzos5UptitmavcZd+xI3FKmwjOx8RM74/845lHxrvpMJm7d7FXrpGCuAkjpwbYpWktqkRchHbcIU2Wxk/Yy5MkpvhxBXMBJY6428617mS23BY9Isars+eel5PXqhqwl0uET0SN/UdanF5c2yy/3Qd8Hp4lEWYiYA71RsHjCBk6ga12GF5qZya7jW7LSOoxjjCVinmgdRlUcIWRniC5/11YNFt/b29bn8YyYoS5vHP4dpIvWFwWgpj0P2l4s/wGKkd39YDGOkIUNMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb0am21oHhgZRr/8XtXIZxb7e1W/d8TNvyKQcH0Y/sA=;
 b=B8WAiwqQoPdaG2ryRYDrUBmKLvWJKWj2xW1EjqfVMSOv6jlLcv2QsssAW2rG7cYWuNohE7e1TI+zHe0uC/0zi6OnQauFN9r5HofgCKgv3+SUGipOIIUI49oOqQi5kQRcmS0gzcVNTBH3Vy+SE2vJQ2wz8cd9eygw3yBVKJ7mog6gBfK0neTJ3ArVhW7Q0s4NhZCxBp7P81uq9zuQ4aapFNI3gnhOVJMTpXXNCOD5WR5yuX4sO4dxvSA8G1QCf6Ar5GcIGVPwIl7aQkMYM5q+tGkbZml0aNB2Blzj8b5O0+61vOkutRTozyPu+wltAVuUo+bYFCmo30XiSLDvxtAj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:09:16 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 17:09:16 +0000
Message-ID: <a010d39b-fd8a-4d36-a7ef-9bda3d2ab517@intel.com>
Date: Fri, 13 Oct 2023 10:09:13 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 04/10] cxl/pci: Remove inconsistent usage of
 dev_err_probe()
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: d135c59d-2e3f-48de-bde5-08dbcc0f21bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqJMNi+c23G5uyR1qRyZ7ptv+4Ag4b+E5MAM1NGlebYWNJJyC0B+LvEo3hB2D2GLnzuJt2DqN12zAM7/AFvlw2hfLRGorUvyRUytur00HV0Zo0rwx7Dngpx0yPK8X62vZ1uAJJUPAauA0FOePM8cNSgDLVj6oPIOp8xBzyac+nq0LsCSRfafsHk/nBcGv2v76/sZOPgDs4HF6qcKz9Qfxhy7rTDRIOOoWqjhPQVOP0lRgVsFQB8njatE5u4RJ65HC3P948YuRj9joL/OJ2AdIM6tqPE390bHXawKJnJzsQSXYRUNBSSrfM+Lx86xqEsUKQ0Dxy6TUqufoGFZhq6gAsLV70cAca7ATCl2f8UGHzs8ZxhX0/FtEdfpr0KXs5ztIB+rJ9UJDjTlTZXeN9TC0MVzzHDwwREvlgPj/r6ZWaj6aU1Z+L7Y92OUM5AcT3nhJox+Jp9a+DjXLp/YqSY036e5vtd7nydxPKGDH/Z0YDXjzDNJRzX3od2kQlWnahwSBMhfaXx+/BgQcUKDS7HWETsmQM6R2yzjMTzrkEQ9UbwZQooY+cBbKrSoTDDsBipTcvDynnzM3GmiyPsweB/21ayxsVr/yFqY823v63ireFFYJ/07IX9byH1+ExuB2sml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(38100700002)(26005)(2616005)(82960400001)(478600001)(8936002)(6486002)(5660300002)(44832011)(31696002)(2906002)(86362001)(66556008)(316002)(66946007)(66476007)(41300700001)(36756003)(6666004)(8676002)(53546011)(6506007)(31686004)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzR0VWdUSzhyVWFhMzlxRmF0K3BCbzhVL21KOVVyNE1KSjd1WXFTNlV0VVlE?=
 =?utf-8?B?OVduY245ZTJtZGJDS2tVOTFSazlvOGMrcFU1OEU2Vm11cVhneW1nZzdaQTFG?=
 =?utf-8?B?R2ZOOTVBRnRiTnZ1YmtYb3d5dG1JKzBTem9VOFl4c0k3YnJKVHkyZFlZWGkv?=
 =?utf-8?B?eHlQd2lVby9NVFRWN0JNRzd3eU0yUWRodzN3UVdwWVVmQVFlRG9XTzBsQ3Jz?=
 =?utf-8?B?YWR4V1VDMU1vUDg4ckdjUVZ1MjFNS1FISU5rUFpPTGs0Ti8yNUc2T0JNNDJy?=
 =?utf-8?B?WTRnM2VQZ3Q2Y2c3QWRBNzRKODhJM3lab1lDZzRCaDQ2MXBwUXZrWTJhaXh3?=
 =?utf-8?B?Y1R4TGtKRnExT3I3UEdnL1pXY015Umk0bWppU0N5dGFsbm5IRXc5dkpzWkdu?=
 =?utf-8?B?NzM1Qm4xam1RVU1XcXRBcmpLcDhYNVBVUisvVXNhUTlUb1d6eGl1R09xaUQ3?=
 =?utf-8?B?ZExPTmx3WUVzVlk1enhEbnIxeldvWW9xSmdjSzRBZVRvNGpmT1FXZThVTjVv?=
 =?utf-8?B?U1VpUVdUcXJtTEtleGt6cmgzcE5abGR1WUlMdXNpSU43a1F5UnBxL0R5TElw?=
 =?utf-8?B?ZUtHNUE0Um9UTUQ4Qy95MjRFT1BMelhiNVYzcUJWQUx1WHFWbUNidVZvSmpR?=
 =?utf-8?B?ay9xdlBmN1p1Tm1WRVBzUnpaT1l2YmR2L1k1ZEpHV1ZkaWdaaVBqZ2JXYUJ0?=
 =?utf-8?B?dmt0ZjFVUHlydjFrY1MrWnlCWUNMQmp4MmNPc2tlZEFJZ3ZXRElyN0VyYlhn?=
 =?utf-8?B?bERQSTMvdW9nUVlUcnltb0pRZGVJNm1zVW1WK3BJa01FSUFNMWwzYUdyazZo?=
 =?utf-8?B?VWFMS1VmVzIwNWpEeEtxKzZUZlhaUFRWb1d3T1kzSlZLbHN3MXhFenZGQVJh?=
 =?utf-8?B?VUIrMGlyWERlRk1vU3hFOGRPdVZrTjRUc1Z2SVNBZXBWbitBVFhaVThFdlRT?=
 =?utf-8?B?UmVoUlBQZUl5T2NuU2c3d1liS00rNnh2SS9KQzdqM0pTTE5GWklmVDA2ZUtD?=
 =?utf-8?B?UkRNRnJ0eDgzNmFOVVd5VC9Rc3EzdmF5SzhpR1EySkMxZmZzVzUrZVFmVUhQ?=
 =?utf-8?B?YVdzTWdrU0F2ZjM0R0Q4TzB5OWYzLzU3NUxUeEY5TE1YN0lyMmR2UGxxYTNZ?=
 =?utf-8?B?RlJvZFJLQzA0SDY1eHo3VGl3a2FSUVg4K05USWY5cVVxTTVxWnFHWXZySE1S?=
 =?utf-8?B?L0Iwa0hKay9HYXFkUlJnS01salpGL21QZFRvZ3Z0YkRPYk45RUJxUC9HTkRY?=
 =?utf-8?B?MHNzNHZQM2tTallJcStQYmd6bGpaalRLcU1laTlOYWNob1dRdy9KM0ROUDdC?=
 =?utf-8?B?Tk5BTlhjaXhPcnNIZzQxZnROSFZYTUdHZFV2aDYyNHg5cHpTYjJnZVBSNTBZ?=
 =?utf-8?B?SENLVDZoaTdXdTF0VmJreGlVUDJacTN5SGR6RkNybmo3QjNwWlZYeVRkSGh2?=
 =?utf-8?B?YTdjQi9pdTllMjRiNDBoN3JONllvNUZNYzV0ZXZFRHJRaWp5ck5mRk03SlRO?=
 =?utf-8?B?cnB4NnFacHFkS3A5UTFIUkh5TTVFeHZ0Z2p5U0VkdlQ1WTd6MVhwei8vUi9O?=
 =?utf-8?B?bnZwOUoxOFR5bHJ0WGFnYmxiOWFtUU9HdnJpQkpCRzI5Q1RPYVBESUFqNmZ0?=
 =?utf-8?B?RE14b0JtRlR1dko4LzZndkdDa2xCUVNBUTcrZ1laeHNlSm9sa2w3ZTBTeGxr?=
 =?utf-8?B?QUlKa1ZDRkEvU052bUFtUHVOUmlIaTZodTVFbkN5R2M1Mmo1dXoxWEFEUFE1?=
 =?utf-8?B?L1ArdFlJN3JCeEJGSXdFNHBPUldhVW1nMFJ1MmU4aVpxckNORkJnaFZwNjg1?=
 =?utf-8?B?U0syY055YlNpalZtcUpLdWF2UUE0NUs1SHNPRnFzbkVKNlVIeWRzbFI4Unhv?=
 =?utf-8?B?eHM1SEtYZDAwRFFSTndwVG5mdlg4WTFoK0dFb2U2SFprK3AybjFyejZIUURV?=
 =?utf-8?B?dVptd0cvTG81dkZFdXJoZzNnQVhZMENQSXR0WUphdzluTW5rZVBMckowaW8r?=
 =?utf-8?B?bDNPWGw0ZXh6aUFJUEM3ajlueGIwWXNGcWVXWUFZM2UvMWNRZkxqS1hVdXNM?=
 =?utf-8?B?Y1lZWEFpWXZUdGpORmx0M3YzRXNtWFd5R3FBM2E5cUVsNlpyQmdNTE8yL25J?=
 =?utf-8?Q?UqAGgIAU/2jBE0SqUm9ucWYEE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d135c59d-2e3f-48de-bde5-08dbcc0f21bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:09:16.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l1EgSRNRT5e7YSJL7v3SYmcwBc3jClCb7hb+IAsh16BfFQ8348GdOFJnrOTud5Z16EnUhwpOr+AHgaBGH7R6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> If dev_err_probe() is to be used it should at least be used consistently
> within the same function. It is also worth questioning whether
> every potential -ENOMEM needs an explicit error message.
> 
> Remove the cxl_setup_fw_upload() error prints for what are rare /
> hardware-independent failures.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2a7a07f6d165..6efe4e2a2cf5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -970,7 +970,6 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = &cxlds->cxlmd->dev;
>  	struct fw_upload *fwl;
> -	int rc;
>  
>  	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
>  		return 0;
> @@ -978,17 +977,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
>  				       &cxl_memdev_fw_ops, mds);
>  	if (IS_ERR(fwl))
> -		return dev_err_probe(dev, PTR_ERR(fwl),
> -				     "Failed to register firmware loader\n");
> -
> -	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
> -				      fwl);
> -	if (rc)
> -		dev_err(dev,
> -			"Failed to add firmware loader remove action: %d\n",
> -			rc);
> +		return PTR_ERR(fwl);
>  
> -	return rc;
> +	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
>  
> 
> 
