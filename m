Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EA219FC
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktSVhiMD"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E059AD
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697216394; x=1728752394;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KsJzp0g1kmSPr4nNgbpgENNIUgArPVORVn0rFldhk7M=;
  b=ktSVhiMD7NmxVhqgKTqVfpFU/OpYvAXrBeskEBoGshA3PwuEdBq9ogaO
   zUtKyG+5xkBvqkh0mU/rtsrqN76HKXkY1ngrI5YUtOakK1Am62FqZYI+M
   wuFojkTfyrD5BSbZdRdwlU7OKZSLAPdzy5gJP3yErJtcMA0v6AOti3PrL
   999u5C7dYGLrvvGb1ZFhXVHqB9I9dW1PVFikkWzvj/No1bXEOewJLFp/Q
   RH2i9YH2e2O9ZNHeTfgd7WmUFdTHlt71RiIbUeO0MdSTwrkEtZhc9NQcs
   SoruenJUczbHRg07CslBSjFtIv1AYDRXAiY2hYITRvBpn1Iit+MUi2ce+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="375573309"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="375573309"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748408377"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="748408377"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:59:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:59:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:59:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:59:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/qNnSzB8JFO6oDcTX9dqM7VTMu9/wk0zn4BqzRGhjsZZm+aBQAawys3COGgSLzsoKTOKkiLiUqzvE4wo60ML+x0lt62O7rzd/RuCgQrfgSClQu4OoxKcgo4Eg2uG1cQE4/oOInNdLGR2x9Cd/r5aYzNnAca1Hv/Kzn/Ne18ZyZMUtcELrbdRjBa5tmf52fxbINfQZN+jE70KebhUJ7Vhemsuln1JQrO0mZItKBrD3qm7Q5stwVOcA2fd378hOFclfmgWvOKZCE7oT4CMV4AkFUZbdCGIDt8ltqUsLehZtdTXe9bzAs8SZdj6rLER5JSW3QZIUbLQ6BiWrTCnavLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QEoxMTBhTLuLoN/a1+qJZPmvuoP49qpSO8A2WBT8D8=;
 b=d2bS91yydzjKcAudRK4tfifFXhKjz1Y2NMkQTaApx/EZokvdiLQZu/jyhxsomuCbXg9fS60HqlKxE9m7dO9wvvBcn5+BibSJG/YHPZAxD9XFwTIwPcx/Uj2SdsRud7dYfos1MH71Y5QsW52IricpOFvFF5owhEC2B3J7dDUvfqYZI3UTGWqU/agF8nz8Een/eAgOUgHnY9G4K9GnqT8cWmxdI3hWyCPdlH89pJiyf5HG3q2QaCnfR86li2KtIq2REWuP7VrT6iXqa+brgb6abzTf6Crf4bjG66CiwaRqMxmkA91TRpVEUMZCn1YWwbZdZD+BHmkxizmNEjPBKFvDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5629.namprd11.prod.outlook.com (2603:10b6:a03:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:59:42 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 16:59:42 +0000
Message-ID: <7bdf592f-8a9d-44a9-b2da-f37d46b4a960@intel.com>
Date: Fri, 13 Oct 2023 09:59:39 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 03/10] cxl/pci: Remove hardirq handler for
 cxl_request_irq()
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a9502c-bfc1-494a-58ac-08dbcc0dcb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OXm8zokGuGJgeyjkcwr8AK4Buwk9oIfZh1mCgWUQqoHN0gkO2ZYnZhkkMbF1JxkpBNU5dacbTyKw33vQYXy6GoVfhzjykQPKFLrJWIN3J9dxVidNAWOQ3F2eweQ8Z7H5rNC79gig2pzWq/Ku+Xwqs/xLkdg0hcfPdOG+PaPdepzHk21CvAEHT2LXAMwaSrW0pQnxQblws54012ycOo3yxEO9T3jTj4RWWj6ifBjmjwyXxdCQC8nNGrKyLTiCbKF1k/nQTiwHJ1yICpJW/Jr8ewr08KGs60SAHYNWxlRJtAdW9018qi0LxniZVfwEPUFiCpkerA9J94AU674Qyo9EYIjul6XkSj2HLUAo+HI3gZJ7vVHShflcARti61EGayR+D13+PCGCPFjIqr3PAyG8wBLcg84PXZSSO/VhGpNl4vKnhCallfxpjz9Vz4FkK52QLGN9sGXmPL4haZG9vpKnHS73xQQRqc2SEZwcE8ICHzCisKV/LKbPZEsbwMIWXIw6GVqApdXQ9kQtqIWvy+w510qEQnDNmj7jGyg2tH6Hpjvr6dev53Zctv3ZdYlpbu2zeQID3M49CQ05yEgsA/afPAyVyNSjJfWGFRPnzMJHHgWSVwSS6nNVt4nlMenz1VS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(82960400001)(26005)(31696002)(36756003)(2906002)(2616005)(38100700002)(316002)(53546011)(31686004)(83380400001)(6512007)(6506007)(44832011)(6666004)(5660300002)(478600001)(8676002)(6486002)(8936002)(41300700001)(66556008)(66946007)(66476007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pKSmpRN0Z0OFBCdHpPZVdTMzUzdEZDMVZTV2hmaFR3SDN3ZU9xRVN5eGVO?=
 =?utf-8?B?VDNSR2RwZTNwMjQ3Z0dEbytZaVloVGRWZU9WUFJDOFpWYkZYQzZYZGZrVUVs?=
 =?utf-8?B?WlVaOVgyaGR0ZmRQU3hZNjZCNkJKS0hIaUZoUjEzUWhzM1RkcWcyQVl3d2Y2?=
 =?utf-8?B?c0JSSGRHNlB0bmh6c3hySWRGYkxiMVYyb20rYmtnbVgyWGNoamlkNmU3Zk0z?=
 =?utf-8?B?ZFFvZ1hTTlA3MHdGVFZScDdGZ3pUZEhpUUthWmtKRnRlVzQyK2oyWko2VW5v?=
 =?utf-8?B?M1J6Y0JBMHdmZFdTZWEzSWtVK2EwY0dtUS85VWNiblpIRGI4NUhOVlRvL3FX?=
 =?utf-8?B?MDdHcDhIOFVoay9rNGpKYVg0Tnl6OFNuei9Ic2U3L1I5M3pSSXErOGdaUWg5?=
 =?utf-8?B?NzcrSHJHMkI1TjRjelB3M3pHanREZE1KcTFLbldlMnhRTTRxNVQ1RHhRV0Qw?=
 =?utf-8?B?cWFLL0dXK2VrQmtsd0pXZ3d1NnBleE12Sm1MQ25iaGp6SmM3aW9qaXNKNDZ3?=
 =?utf-8?B?N3JtRGJ5N3BXLzBIbkI4KzhEQTYyQ08zQTNUV3Fhazh0M1N6V3BWSUo3ZFhQ?=
 =?utf-8?B?SVNHU1JhaWs3UTBuVXM4S1NLbGU1OXNZN3dWdEJHN0pBUVl1OERGZHhpL2hX?=
 =?utf-8?B?amhJaGMwTGlReHVNZmNhZHFhYkx6RktRYWEyRFVWU3ZxQnZ1WFhIWWlNT0JB?=
 =?utf-8?B?UVNaWUNYd1MrNlZRUVZYWm9oQ2Z5OUlaWTFGOFdrOEV2U0dyNnJ5UFcrQWZU?=
 =?utf-8?B?YUd2SlF4YlhpSlBTdWZYVFpRUk1iajBIM0dSS1Bub2tUcmNZdDUrd0FNb0Y0?=
 =?utf-8?B?YmFFYXpDM3BFTFVkclVnYUcwb3E5ZElmWWN1Vk5QSEYwT3UrN0ZCRTg5TnN1?=
 =?utf-8?B?bFhHNmpDbUVGSjJLUWtSSTdtVkZ3L1l0eWpQZDhnbHo2UWN5Q0NCOHhnUWlE?=
 =?utf-8?B?L2NhTGszZEFCekpBbGdIbWtTd2pYQVlXTy84RVZlY3R2UTNRT0Nqais1Tkx0?=
 =?utf-8?B?NnhDNFQvQmo3NUxGcDczRGU5Q0poSDZzNXN4Y3E5NExYaFJqWEx0ekFZa2JP?=
 =?utf-8?B?YmcxS291Uk0xUjR0WDljblAzMFVISUFWWFEvbUZDY3Y1bmM2NVVLT3RqK2Rw?=
 =?utf-8?B?Y0xUQnZLcEsrOC9HTWdqQ3lTNzBNOVlOWENBVU8wOEZYam1uTWVkUWRKOTJE?=
 =?utf-8?B?ZlBoNnNTbnNBcjhZeXZMY1pxVHVMa1JrNzN0OEhhK0RLK0RRYnJmc1dxRnJq?=
 =?utf-8?B?K3BUait0bHNpczNjMzYxWGE3UW9Ddkd1SUI0bkZHLzJmTjJvc05YTWFyZksy?=
 =?utf-8?B?UWpFMHgrL0NPY2JVTDFldWFkUFcwRkhGYzFHRXh3cTJNWGd2VlJweGlmWjdD?=
 =?utf-8?B?czZua0xyYWZWQmhNTitkRVlJUGFrSmZrQ1UzbDdYSEZSZkhYdHY1azlEbmVV?=
 =?utf-8?B?bmlrWWpGSjErSE1jVWhkL1RMcTl5QWRaaFJJMzhRTkpzK2l2ZHpLUkNCOUZk?=
 =?utf-8?B?OXNXL1RSMUU5WlQzR1BJU2duVk9JaGJLYXByT1hHRTZYdlpwbnA2UnYrSSs3?=
 =?utf-8?B?b2xuVjE3QlpxNm1CQ1B1eXVuZUg2WTQveWthN1pHQjFxNXdxc2NtYVplN09q?=
 =?utf-8?B?V2J6RjQwK3d3WHZRdThuM1lVS3F1R09GbUdiYXlIU00rcENwbFNGazZpeTQ1?=
 =?utf-8?B?K05CemVCVzhiRkpaN2hKMW9vVUdBZEhXUkN4dXRBM1lDUWxWM2hQUmlqeFdL?=
 =?utf-8?B?Y0w4NmdoY05LWEREK3Eyc21JenZLN2xvQzJEc2pFOFlNVEdHMzJaREloTDRL?=
 =?utf-8?B?LytXTmxMWUE4V0tXSkVhVTVBbnpuQlRpbjdZOUtJN2tiL054TVA3L0k0dzhm?=
 =?utf-8?B?MzdqS1crQUdNVHljTUdPa3lSYzMzR0htd3lUbG93ZjhIYjQ2YmRXRHNWaWRQ?=
 =?utf-8?B?OHBiSGpsdmpyNllXR0xCTndsTGgvL0JDZ3c0emRObEh5ek5tdHVreDc4RmVR?=
 =?utf-8?B?QkUvc0Q5WmRJM3FLd285TGxoNDNUZ25kUmo3M2RNR2phYzVtdUJhbC90UWIx?=
 =?utf-8?B?LzRVUmtqUmVNc3hiaUtVUlVXUW1kbnl3dm5KcnM1WldJeTVRMUxRL2ZQcThD?=
 =?utf-8?Q?b0YpQWIKvU2RLX0vHi6jWEtfh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a9502c-bfc1-494a-58ac-08dbcc0dcb4f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:59:42.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ocoq7JwVoSXp71j70Snis9m/TijLFxXobyw9lF7X22JYlaVLozu7Kn8s47HX/kbZrV9V1ZIV/LZmz6JgBQS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> Now that all callers of cxl_request_irq() are using threaded irqs, drop
> the hardirq handler option.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 49d9b2ef5c5c..dc665b12be8f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -90,7 +90,7 @@ struct cxl_dev_id {
>  };
>  
>  static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
> -			   irq_handler_t handler, irq_handler_t thread_fn)
> +			   irq_handler_t thread_fn)
>  {
>  	struct device *dev = cxlds->dev;
>  	struct cxl_dev_id *dev_id;
> @@ -101,9 +101,9 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
>  		return -ENOMEM;
>  	dev_id->cxlds = cxlds;
>  
> -	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
> -					 IRQF_SHARED | IRQF_ONESHOT,
> -					 NULL, dev_id);
> +	return devm_request_threaded_irq(dev, irq, NULL, thread_fn,
> +					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> +					 dev_id);
>  }
>  
>  static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> @@ -440,7 +440,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (irq < 0)
>  		return 0;
>  
> -	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
> +	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
>  		return 0;
>  
>  	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
> @@ -638,7 +638,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  	if (irq < 0)
>  		return irq;
>  
> -	return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
> +	return cxl_request_irq(cxlds, irq, cxl_event_thread);
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> 
> 
