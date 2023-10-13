Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017C1BDE2
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hnr3OnIh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29795
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217135; x=1728753135;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8hrsuGeW+5fubnYII+YclOFy1jki8+6Oh7E+B3IetyQ=;
  b=Hnr3OnIhn0vQMezOkx/48WTwaH484PbKC+EMtJlfh5Wq1plIFk1g8T61
   tL6iGJUn3lUPaDy9KXnW+6C9e49c62lnxW0mTLretcdgZD54H3dptUZiJ
   TiEJLgIdk+AE9k29qjVltDLfgSkSpLd7Xqbzkwk6z7nMlK2skUdinBugb
   J0TOlQp0HYbT5A3QMb4dhk8vZy/lB2O1zunzuAryO9XvvyoGCU595b495
   1o71/U4g9tAoCxbnzpaK8ZHPEmpauVlY21JK/Rx/o4XW4KCPIuP1+e+O1
   2CMyqlEMAWzKYL/NUmN0UfjjCqVGFvyT+2AsOI42WL8k3JNIj3ZOCFJ+G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3828380"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3828380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754767420"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754767420"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:12:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:12:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:12:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrPOAU+WWWzUgQ++mxwYNnn23oT2w7GAq2OlyM0XXP48DKiMMxGOxY7B38D2oKVedFwUoEiOnpBrSmZBenU2vuZfq4P75mae47KIUh55pg0GTbJG9KBIII1h7mgpu4nQA9DlzHO1oYLKD8y1QIfJNxvYN6eLAMLPstXx/XFC8V2ckJMFv+BHg6v791Akm87LKt/osYrS/KgusFjaujaT0b+Ef0L1oOqjE3MIv0A2X7YEquFWBdwux+tr3TVUO7ua7p44PRt8XieY2UJVR6d91YTvNv78icz6xWKO9C4/vEdq6UkMTb03vV+nCH/i1k8A+hgz+06ZI5xawdUVJHnUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l7lb5fMWO8FB3xQhxjZYYebYHIvNzulvUrU+HoQyk0=;
 b=QfPjPvRSTDuqZqz6cHCn/cYKFvQ8j2cka777+yuMtSLWyuJ7lE71GtFR4YXWmdi/0AY02vFwFrCQUOP874RyHH8pn/24pgwwtm/MV9kV4BDMierKeFCdIS3tfSn4UZ1hspGGURnClME/6BkojR0WpKrYBpYKh/xZSV8rvjO4nG3q3e5aQz19BRwZGrUGXDue0ol+3VuTtFA3/PQCNWfzZ2QCCvQTIjapTB4RKLMWNgqGe0XGAcLsvkhjQV8HLNCgxtP0UboOyam/9jwozT0UvWgH8xm1b1GOsjBoSKh+PgYuHgDcIA4CIZugd9aQxRnOfP+Z8q1YQzW8qnke6zX2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:12:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 17:12:06 +0000
Message-ID: <c254a4f5-aa94-4519-8b82-9a85917de5c7@intel.com>
Date: Fri, 13 Oct 2023 10:12:04 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 05/10] cxl/pci: Clarify devm host for memdev relative
 setup
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: dd534038-73c6-4898-8f92-08dbcc0f8713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: su3oMDmKXJS+H7+esmbo/FKm40rEU1hg2ZAJYgBhtDkH6cwPfj6kQxZobrJnofHa9PnyQW6nd1mYQvZQZwpxN5NLKS1RE8do1acl0DMg9OzurBMko3ttA8PCTcdm4AMXTIfxf024X4Fc9YGDd5rsL+kBGc9NY7a1GNrvvKj8ybZwaQ9/PfFdoEyrexsaRsvvmx89FEHXsUrv6CaOQcLFJiT+5BBXT/mmxRILGLETM9zTourRLnA+t13YlR4XgwDP1P7EA40rsTZ2VaFMSmshOgOI7EW8ukGvcFUAekSXmA772Pp/yr4nCJdrwcBG7D5Uj9kmKDFBc/7zczL5tVzqzxEv8eC+4AVTY5f3wcq5xncfKBmhYHTSNzkhg+MTUCErP22oAywsY9iymyjU10M2Z1MWaYgonmjtlZtpUE1kiLZPXb9rJ0LuzVTQPoA5F53WtKkU3HvxXEvLdMHPYWxvvIr07yhvrzw/RjyOtgnbowFFBplU4UJ75cdBvUTn+LwSu9i5KfGt5MrbGR2odpibs+mYzXBUQFfFXYTWHjx9TGamw+AHBUSf1YK1+RK765gVd03zu+coZcXlv5uVztNKIPr32bXSQMYACdxAzMYA7PAhq0kUWcuGgCHGgqVwuUP0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(36756003)(86362001)(31696002)(66946007)(66476007)(66556008)(38100700002)(82960400001)(316002)(83380400001)(53546011)(2616005)(2906002)(6512007)(26005)(8936002)(6506007)(8676002)(41300700001)(478600001)(44832011)(6486002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVdSZjh5UVkwenlxMzdKZkhlWXozTnd2QkJpbTljSzZzTjBPcTJtWEZSNHcv?=
 =?utf-8?B?NHg4MlFnWEtTcHhrMXNZQitnVjFiSEdHZElLazQ1SVI1MEVQWGhEdGVaV1VT?=
 =?utf-8?B?cnJLZm9tUCttdzV6dS8xZjdvSDkxZzNxeUQ1TFFmRGRZcUJzdVUzTmVxbGxU?=
 =?utf-8?B?Z0FXcTljUU83OVVyUXBQYWthTy9kbnRVdW5zSmhCaE9rL1lMWVhzQzIxSTMw?=
 =?utf-8?B?MFhsQTc3RkNDdFpKYWMvYkgxYndQVGZpallxMS9HbjM3S005TWE1TDRzdmJv?=
 =?utf-8?B?TnI0aHNydWd5VGdDdVRjQWZobUF1MEFTQlVzenZ5Wmg1NFZGdjQyMm8rWWZq?=
 =?utf-8?B?d2UzMVZGaDh1ZHhRQVY5S0FEdThOR25NQks2dTcxRktIYTlqaHlBT3FBSFJk?=
 =?utf-8?B?MEVZOHA3QUx0TWU1UUM3U1dGYk1WV2Uvcll2QVdiZzBFYkdiaGh4OUdNNTJ2?=
 =?utf-8?B?MldXWVROMjdKUlNGOEZwd1M4aWlHVzZFanZta3V5bWtOSi9oaS9FNWMwNzJq?=
 =?utf-8?B?Y21URFVqNGp2djd3OEFhQ1U2a0h3SnhKbDBVWVpkVFZUTzBGOGovQUh1TlZX?=
 =?utf-8?B?QnBTUTdBM0N6bU1sUVFveERKVGZrODZQODJqeU5vSFZCQXJJZklOQ1E0WDU5?=
 =?utf-8?B?ZVhLRGV2SnFCQjExQWc1bDkwYW9qM2VSdzBxVXNyQit6alhWYXJCanM5UVZz?=
 =?utf-8?B?MFVCdWRpcTBxbzF0aXBodUZ5aDRYUlBYQldGcTFpdVpDbTVOLzF3U3VNQ2RB?=
 =?utf-8?B?U0I2Z2piUXJDVFdkRWFTUnBnRy95aTBGTXlOWU5GQ29Oc3d4WFRiV0NGOENC?=
 =?utf-8?B?ckE3eFlHVGdELzEwWWdsRG1ibGZ2R2dWSWo0SmRsVjBmbTYwei9oVFo4Z3FL?=
 =?utf-8?B?amNoZjlLWDJMUlBJYkc5bFZtV3kwT09nOHdHeFZtZmNaZ0l6dFBXTnQ3UmVp?=
 =?utf-8?B?V0k3eEJjT0JUbnNiL2hzbi9QQzQxaHpZTzd5YXNDT3ZtaDcyQVB3Y2pZUTlQ?=
 =?utf-8?B?UkpXbGRoQW5BZzFJK3BBZmNESVptNHN6b0tZbloxMUdkT2c4aTF2ZGhlYUp5?=
 =?utf-8?B?MzZOMytkbnQrTHFXek8yK3liM1dSbkZCcTdWaTdCbTk3cVNNbGtsSzdZWDM3?=
 =?utf-8?B?Z1RwYWlLUTBpQ085VUxoUGp4YjVnbmRWSWZUV0cyVFowOHEwUkF1Nk9XWnVk?=
 =?utf-8?B?NHl1dDVObTFBTjV0RmxQS3V1NUp2Q1Z0TC9ZcEtrY3g4L0lCaEhVQkk0eGJi?=
 =?utf-8?B?M0c4Q0YxMmV0TkpSZHNKTno2eFhNYWZML3IzS0ZPc2xIVWJRa01tQjFYY1dP?=
 =?utf-8?B?SUZMQ0VwUHJCZlpSdFFlMFVzd0dkN1RhVmpVd25VcGo3bkVzZ21UcWtSMjZa?=
 =?utf-8?B?VWhTYVNvWmQrZTVFeENwY3ljSXIxZGR0dzZnZmR3bkI2L0NvMFJoQjhpZDBI?=
 =?utf-8?B?T0EyS2dDY2VXRHlWYTFsM2svRzZ5VzFrL3FGT3drd0RvajR5MjVQTU1lb2Zr?=
 =?utf-8?B?MTBnWkZyQ1J4Mm5JMk1GWmg0T1JyRHZ2VFd3T0EveXpzd1B5SzF3NTJ6UlZo?=
 =?utf-8?B?MUpZaTNlMGNnZlRPQ3FhVXlyYThzSEcrZG1vQ2pFSkc3U3g2V0VPTjRmc05W?=
 =?utf-8?B?UDF3NlFVVEJMd0pWc2FleGFvUDJFOXlWZ0pmSTVOR1FsZXhPbXBxOVhraDlO?=
 =?utf-8?B?a214TU1RTXM4dHY5Ym42bGMzSlhUL2xUN0R3ZWQrS1pUMTBLWnZNUlFnUTJr?=
 =?utf-8?B?UUpIRFREbk9BdDA2REhFYk1mTTJJK2U4TjN1R3dNLzVweXdzWitiOVdzMXo4?=
 =?utf-8?B?RDN1YklFOStKMnh2Tndrc0k1Wk9VakxPS0pJRlh2SEpRdVdRTGoxbm1aSWty?=
 =?utf-8?B?Q0pVU0xWeHhUS3M5OC9iLzdHL2V1anhqMDFnN09ZUDcvb1FQL0FCVzJ2cEpF?=
 =?utf-8?B?S3pZTU1sRTl1dHRTSzJicG1Ncm1oYU4yc3VUdE83cmNGYUIwTnVVUmlsbGdJ?=
 =?utf-8?B?OHc4QnRab1ZHZXg1WXdJeDdiTFp6aWdyOFRjZFlaUjhEcUcvNWd3YjdhUFdO?=
 =?utf-8?B?VzBrZUJodThyaUUyME5TaDNrRG5IZXJ4YzFFcTlGV0FGRmxHNGtFYWdZYzZr?=
 =?utf-8?Q?/YBJwr64oeo+Q2pgDfuauqZM6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd534038-73c6-4898-8f92-08dbcc0f8713
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:12:06.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pdmi6Tj7B/tE2ePpa1iw9YD6r+Y2kGLQfX1bl0yvHtLcjpUKJR1Gbf+yGKOnuHL/An0s1tJRXXwdTz99/uUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> It is all too easy to get confused about @dev usage in the CXL driver
> stack. Before adding a new cxl_pci_probe() setup operation that has a
> devm lifetime dependent on @cxlds->dev binding, but also references
> @cxlmd->dev, and prints messages, rework the devm_cxl_add_memdev() and
> cxl_memdev_setup_fw_upload() function signatures to make this
> distinction explicit. I.e. pass in the devm context as an @host argument
> rather than infer it from other objects.
> 
> This is in preparation for adding a devm_cxl_sanitize_setup_notifier().
> 
> Note the whitespace fixup near the change of the devm_cxl_add_memdev()
> signature. That uncaught typo originated in the patch that added
> cxl_memdev_security_init().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c    |   16 ++++++++--------
>  drivers/cxl/cxlmem.h         |    5 +++--
>  drivers/cxl/pci.c            |    4 ++--
>  tools/testing/cxl/test/mem.c |    4 ++--
>  4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6efe4e2a2cf5..63353d990374 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -960,12 +960,12 @@ static const struct fw_upload_ops cxl_memdev_fw_ops = {
>          .cleanup = cxl_fw_cleanup,
>  };
>  
> -static void devm_cxl_remove_fw_upload(void *fwl)
> +static void cxl_remove_fw_upload(void *fwl)
>  {
>  	firmware_upload_unregister(fwl);
>  }
>  
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = &cxlds->cxlmd->dev;
> @@ -978,10 +978,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  				       &cxl_memdev_fw_ops, mds);
>  	if (IS_ERR(fwl))
>  		return PTR_ERR(fwl);
> -
> -	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
> +	return devm_add_action_or_reset(host, cxl_remove_fw_upload, fwl);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fw_upload, CXL);
>  
>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
> @@ -1019,9 +1018,10 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> @@ -1053,7 +1053,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
> +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 55f00ad17a77..fdb2c8dd98d0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -84,9 +84,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  struct cxl_memdev_state;
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds);
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dc665b12be8f..7c117eb62750 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -867,11 +867,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 464fc39ed277..68118c37f0b5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1450,11 +1450,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mdata->mes.mds = mds;
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> 
> 
