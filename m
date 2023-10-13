Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C41B280
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhvGO3zT"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213CAB7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217941; x=1728753941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WVhoucYHnwR0o3rhuEeXczYG1vlcPMXrYuMLCsiQHTI=;
  b=KhvGO3zT/u57vWaxqzlnM/WUskyIc0MPB0ySzAOQtORn4zW+8Oc2MGr9
   2JAyC9JJ27OZSlivSodZ+kS1hByAQyLApsCYG+eFKUAvndI4MHrGhqsSg
   bJj2btnCU2JdIHaBM6uL0cy/GCMU3aFsKzJKjUNAT7vABqMNaOzPlYUON
   4E4c6yHFkjKALK+6hyAwkw2T4+JS/wmHuW66k+9lxzLq4avu/SidvynM1
   LjyVxlc2mAB89617bPZTW1A1GxVj6HSn4NCFzi94x8ZjAA3lHVQ+iCCm/
   wIPClIFOua0BWJJkJp/iHgIjKdXcVPRrLQw93DL4wD1zh2pSQyrdDmP71
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="451711159"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="451711159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="820720753"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="820720753"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:25:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:25:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:25:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:25:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD6JS4ZSANc+vPEHD6Ay8Dw1uHPaoXVfY7hjYJOGCIb3sM73M8pm5GMSjJRvPIBPCAN58ZAVjdOvxBWL8/++8iAEMpRiTNPTU4hGAKwdqXijOAk4YeXy6byZbIUIKVrUUAocZtFlxYe1tkZyEXTjEia/MszOShxjsr/2HrBBJwxlXDihR784tC5+ATHP5yt+Vi3UywvU9Z/r5uQRHDGO80tN9Erws0cJdU9mxDeEB2p5CNFAHIrxbMZNcwgfDQ7LzkeuhOB4J2jf7fC2LMF0QoVS4Cwra6GN2xUrD/aKmEbzViqeE2g/GIwnnintVC8fgc6fUb7S2678VwbDlOxGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8AYCdgfGNtV7jpnBHVA/7DqLQQWwa/79M3ZItLjWeU=;
 b=L61+1R4DAcATAPGjius6Z56FK9L7bSMvsiKcLt7ZUs7maRYbU2av8ACyil83Anv4o7nvROb9UDhCrpLMkzaLz8fG/yfx/uz5y3LqxXxce0xs6WjnAap0oBf57RU7VpSzhYJUNSKidBb8LiwoevyBB/sZa4K3c6jqQI6zYyZ0TUgH0gDJ4yeatZx8zkXA/ECMN/KBxzxkK917ez3NzctEF6Mtc2vYUnkAGPxI2wpIqGDymbq6cR4shMWNHgIK2wQ8Q6X3whstFsqvVu/wqkB/wzROiDjOA23Shhd5dlr00/Uor3TOCu62z5mYQrY9RKLIE1a7ez2T/VD9WcgT7bFGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 17:25:35 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 17:25:35 +0000
Message-ID: <e8a085fe-303d-41b6-82da-4a79b5e735b0@intel.com>
Date: Fri, 13 Oct 2023 10:25:32 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 10/10] tools/testing/cxl: Add 'sanitize notifier'
 support
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657721756.1491153.17305814762884004365.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657721756.1491153.17305814762884004365.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: fa54c017-f71d-4697-4dd8-08dbcc116937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRwt/QSkcZquGRim8J0SoDD1T8sV2ZbyMuIYVy96kVPCA2MAE4StWAqWdREfF0qy+J9acrxY+jV6OPLlhR+hJAn067thxQcy9RZ2DaLToLVbp+hHZBWoMh9Cps9XOAL1ND6qlHVJmKgaGanAGkweeOoJVjCT/xOnGy/IrAbZwOiNVKMADQRfCqXBYew0rNYuRf98HxA+XY6IAAQJ2Ev9Q7PRjRDkez02GdJqA43B8NJnOkYkKaTdaOQw+X5aI93s/H/KOIgs+hFA/l7BB1U+AWrxAadfC8UUonpriMSVmbfJ8ahhhWMAOXSH6U+LHB1L3EoZfwFaJD/9nllDIS2IlFxpeiCW8yIpVcqomPrqMuQ48X+rRJJxAXieY/F5CA/c6k2Mp6L03FQuvxGc9XElJl9hg13Q5UsH6ylOgAWSj3rEiksEjbApYTuxyhBv/uJ4T81vShE45Gup11e8nUyPW1wo3NZdfLzCO9oR0Zj9DBhp4mvUGU1V+cw5Z7H0q4CAk7/Xp/YG8MvdKepKVR3enPRbjg9s4DpmS2GtqvhXJTx3qvSDeU5w9KPgRXqJwfzptY4gBTITPLrIj7sv7oCBdCNaLyrbnlwSn/s2IlPL32WDu79EiaBM/7RXxD6LoW9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66556008)(66476007)(316002)(66946007)(2616005)(2906002)(26005)(6512007)(41300700001)(44832011)(6506007)(5660300002)(53546011)(36756003)(6666004)(8936002)(8676002)(4326008)(83380400001)(31686004)(478600001)(6486002)(38100700002)(82960400001)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zjk2SHl1dUkrNTJKV3ltVWh6dmxxOVQ0UU1YWTl3Qk11Y3FmYlZlRnN5b2FD?=
 =?utf-8?B?Q0F2dURFR3ZHNTFMdkJpSUJUNWUxL0I2Rzc0VTlXTzB3ZGc4RlppWjBSWXBP?=
 =?utf-8?B?dUhmb1grelpRelJ5OEI5L2F0K3BKN3JlblVOc2NYc1g3T0VuTzRkLzJGb0tz?=
 =?utf-8?B?eFBzRVpKVHlDRzRKT1F4NmtJKzFSWXBWRlh2aHNHcUg2Nlp0Ukh4V2JGdFdZ?=
 =?utf-8?B?SkJBQU5neTFYVnVMNjBld1VkcU00d3dHeFloamM2WVFYNExLeGlWb0p5TDZU?=
 =?utf-8?B?Yy9kTlZ2TGQrc0E3VEJ2Nm5DeGRpdEdXMGtqYTJ0WEwreUdJZ1ZZVkZpWkps?=
 =?utf-8?B?NFhZK2xvMDNkR1MxdjhTNEpmallzUFpYMGlSaEVQTmFQRSsrNXRTUExkVm1p?=
 =?utf-8?B?TUI0MGRhVXREdlZGRVp1QTNJUUxrNUZlMUgxOE9RY09WZGJBcmozVldVUHBo?=
 =?utf-8?B?aTRGbHFnOGtsL0o1bVYzSlJXenFicnZsUnNOblpYV1R6QXE5cVhEZndnRnVN?=
 =?utf-8?B?ZWFZVjRTZ3JaOEJPYzFqaGFNTTk5bUZnbGFLSjFPVGFmV2JPTWdmcVRaZmU5?=
 =?utf-8?B?ZXo1L01KY2l5bWx5RkdrTFUzZU5Kbjk2WXZGMkVDaE8zNXF0blA4R2htTjFK?=
 =?utf-8?B?UWk1Zk1kckpnS1oxQ1NVK0hIOFFuY25ja1o3dDdhSTJVSURXNkhjWXl3R2Fy?=
 =?utf-8?B?c0tiWkdJVjBYK05LeWNzRFVhUmRKaExyWExSTWtvWUVTcFRDb0Y1d1B1Szlk?=
 =?utf-8?B?cjI0aUVucmxVWFRRMk5qODVzbU1zMGFFeWxNSHgrWHhyd0FnelhzOGs0eEhh?=
 =?utf-8?B?NVpLRW5EMkdFVjB3eFh2SVh0MkhTTlZBVWRobUc3L2pCc2s1N1RZSGtqNTdL?=
 =?utf-8?B?S0hpMHZyVEg1VTdJYTM2OGhDdUFscWlDTzc0L3VUMkhEdlBmbFRmWDd5TWtT?=
 =?utf-8?B?Rm92ZXFYTEVmSytEYjVUdWF1bVJhU3g5SGR1YnlWQ29heUhQMmdLTitESWhQ?=
 =?utf-8?B?N3I1ajNKaC9UenlJcnNhZklBVnpZNnZSN2RvMFJuRXE3a3lxVitDOGpGRmJn?=
 =?utf-8?B?RU9KUERTOXZucnBQZ2N0QzRwa1RYUTIwSFhhdklOWDNPS2dWamo0RDRPeVl4?=
 =?utf-8?B?UHArYXFjc0RrcXVTQ3JFN1JHbnFsVExTOW1TZU1lUWYwWW9WWWlTY2xFTk4r?=
 =?utf-8?B?ZW9YcVpyYXRLa3FFMnQ0aWRoY0plNW5KdWdVeUtGUk1TdVNScHoxSEl0VlN6?=
 =?utf-8?B?WnR5NTZvajBLUEh3OEEzT1kvcWREaHR3L250NUNqa05oV1YreDN1SDJ0SzRh?=
 =?utf-8?B?UzVQdXI3L1N6RGtncUJKS2lXY1dibUFrRHE1UjNINWV5KzNNbGw4ekd1WWRB?=
 =?utf-8?B?VTNYajVFeEpyRFlSek9ZMWdTV2pSakFnclAyR0tLVmIydnR2Znlra09JMjND?=
 =?utf-8?B?QUIrV01yY2NrSFBQVlFqTEdMekJZeHdFeThNejhYQnBIY0M1TWtZREpTTzJO?=
 =?utf-8?B?Nmgxeml4a0oveE9HV2JFYWtGRVA2T2pIQzlNUFNMcGVpa2xXVzJjQ3VUMnRY?=
 =?utf-8?B?MTV5Qi9PUEx5VTNHV09tYjNHVVEyOWVFVWk3VDIrbWpFZTExYTJ6ODFNVlZt?=
 =?utf-8?B?aWI4MjNaQ0pGaW1xb2lSQS91d3pVYnZGMlppSUNkQVRIMkYwcUZvcWloSmJs?=
 =?utf-8?B?WVpWK0c5VEJHV01nR0RLWVM4MDNKLzBrSkpqcVpaTUtrRGdMZHZVTGVWNllJ?=
 =?utf-8?B?TjlCM21ST25INTBrUGl5Y1VpV25uQy9vUEovV0NNVXBKVExibXBadEt4SzhM?=
 =?utf-8?B?L21BUlA1NWg0WWFCRHpOT1FuSGcvaStlcm4wbFJUSUgzVzFVSUZYZWIvWmNC?=
 =?utf-8?B?Snd5aDZLRjNTckIyeVRTS2VxY2pRNkk4NmpNOGJFaXYyODdzcUpkNG1zSlZU?=
 =?utf-8?B?d1dCTjhQc3RMcGlTSGNROVp2RVRNZTVDU1Z3UUUwUVMyUU9PQUQzdVV6RmpL?=
 =?utf-8?B?eGtscHlvNDM1RkdZT0xYZDhJelJKUU5DeVpsdy83UkhyZE5TY2t1c0lDUkUw?=
 =?utf-8?B?MysrRDFibjRlZFNsQ09OWFkxSkc4eGlHQlloa3A5RlZ0NHBBVlBlT2RvK3V6?=
 =?utf-8?B?ajlFbU1hcnVqdVpLZFdYMUxpWVpjb3RudW5Jd21kOEZCOTFCTHp4RDZwQ3Jm?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa54c017-f71d-4697-4dd8-08dbcc116937
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:25:35.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyaFiq87Hn2OEYTwnQCR3tVbKzWlOCfd6lBAEiBQ20t4/8Rw59Uq/CKhJoHWF6et7gCn9WGFLgKPSI/Z5sFz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> Allow for cxl_test regression of the sanitize notifier. Reuse the core
> setup infrastructure, and trigger notifications upon any sanitize
> submission with a programmable notification delay.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c |   68 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index ab311b59899a..76bdb1ac5816 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -89,6 +89,12 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
>  				      EFFECT(CONF_CHANGE_IMMEDIATE)),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_SANITIZE),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE) |
> +				      EFFECT(SECURITY_CHANGE_IMMEDIATE) |
> +				      EFFECT(BACKGROUND_OP)),
> +	},
>  };
>  
>  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -152,6 +158,7 @@ struct cxl_mockmem_data {
>  	struct cxl_memdev_state *mds;
>  	u8 event_buf[SZ_4K];
>  	u64 timestamp;
> +	unsigned long sanitize_timeout;
>  };
>  
>  static struct mock_event_log *event_find_log(struct device *dev, int log_type)
> @@ -567,9 +574,26 @@ static int mock_partition_info(struct cxl_mbox_cmd *cmd)
>  	return 0;
>  }
>  
> +void cxl_mockmem_sanitize_work(struct work_struct *work)
> +{
> +	struct cxl_memdev_state *mds =
> +		container_of(work, typeof(*mds), security.poll_dwork.work);
> +
> +	mutex_lock(&mds->mbox_mutex);
> +	if (mds->security.sanitize_node)
> +		sysfs_notify_dirent(mds->security.sanitize_node);
> +	mds->security.sanitize_active = false;
> +	mutex_unlock(&mds->mbox_mutex);
> +
> +	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
> +}
> +
>  static int mock_sanitize(struct cxl_mockmem_data *mdata,
>  			 struct cxl_mbox_cmd *cmd)
>  {
> +	struct cxl_memdev_state *mds = mdata->mds;
> +	int rc = 0;
> +
>  	if (cmd->size_in != 0)
>  		return -EINVAL;
>  
> @@ -585,7 +609,16 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>  		return -ENXIO;
>  	}
>  
> -	return 0; /* assume less than 2 secs, no bg */
> +	mutex_lock(&mds->mbox_mutex);
> +	if (schedule_delayed_work(&mds->security.poll_dwork,
> +				  msecs_to_jiffies(mdata->sanitize_timeout))) {
> +		mds->security.sanitize_active = true;
> +		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
> +	} else
> +		rc = -EBUSY;
> +	mutex_unlock(&mds->mbox_mutex);
> +
> +	return rc;
>  }
>  
>  static int mock_secure_erase(struct cxl_mockmem_data *mdata,
> @@ -1419,6 +1452,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->mbox_send = cxl_mock_mbox_send;
>  	mds->payload_size = SZ_4K;
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
> +	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
>  	cxlds = &mds->cxlds;
>  	cxlds->serial = pdev->id;
> @@ -1458,6 +1492,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
>  
>  	return 0;
> @@ -1526,10 +1564,38 @@ static ssize_t fw_buf_checksum_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(fw_buf_checksum);
>  
> +static ssize_t sanitize_timeout_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%lu\n", mdata->sanitize_timeout);
> +}
> +
> +static ssize_t sanitize_timeout_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int rc;
> +
> +	rc = kstrtoul(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	mdata->sanitize_timeout = val;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(sanitize_timeout);
> +
>  static struct attribute *cxl_mock_mem_attrs[] = {
>  	&dev_attr_security_lock.attr,
>  	&dev_attr_event_trigger.attr,
>  	&dev_attr_fw_buf_checksum.attr,
> +	&dev_attr_sanitize_timeout.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(cxl_mock_mem);
> 
> 
