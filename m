Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75F1B280
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHkjZP/N"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC07A9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217706; x=1728753706;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6SG5Q5/nI2YO5EOZofRa6psZXyGSUKrmYkDfJbLiKL0=;
  b=UHkjZP/NCkWPNCFeb3uMH2cZxDXnHGZPumq4CxJ5gnkR/YlX8W/OOpsV
   Qof1VfmWdk5UGwkm9LnHTAMj3Bei1BksdauG8AZMmxPDT3KRxMtlfSgcm
   IoNcekjiSH5L69gX6gqqgfcYHCbs8q4Kkjr8kiXxxUy3brwpnZVUtD8tK
   GS4nMb+YaEFSF6hFUGtuZJ8nMqD0VTacaX1qsRub1bs4cm0WVyvScAh3J
   t9WFvtcbQcVozPKw5svy0QhT272wcw7UH3UbkolOKoJ+W2dR5EpZ+v9df
   75lXqaQ72V08QHnjpwXQrm/GKDYdZiS7TwGwYe2xGuwqFJMKqTHmok4st
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="365484934"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="365484934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="704717901"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="704717901"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:21:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:21:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:21:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9lS98f0nIsCOiwYQojcKi8yJr0rsvCb7rejzJ7aRGF5i/2G8XOymzlEvkiGqWR3UNlhQCY0XSQbK0tie1awA08l7HHMzhwl3VIdOX/DFi1OhuzxMahU93uuKZw8uLBhBcIWkusRD/nG8ZJYr0EG8LiiNCquiqLVSa3CzvdehnLRFuccfhP+ditMGaLm1sq4FDCJrlJO2s+x08W6gzdnFsyAgna+NzsY3bC/eVabeow7KnU7t5jAwhLgLlqmHRdpaWpaMsEzgX3BkRJALXXSbTbtfEVoWbrQWBEwSbwOWmZZ2Fdqnr6KE63icvoZitNUjvi8/qwrBsj4Co31MzqgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F77sqeyGOAQm6q2ZP+XlFBMMYEPIA5qCKlQeZQpNQA=;
 b=igC2gqHLWdUPg0SHYIbh/cJWksSrqtPOVG3oIpBL9t+ESxa2MpUKLslPvIVMZYN5UwvSKPtJlcxKi/kly/Y6r26EBFY5kgFjaC263Wqv140FML5UOPM/pOadyyOh5Cbo33nz3vTlkJrdXTir5QSsuIWtw53nYnkgIC3akM+na+JNWT/ErV6muDlUvU1QjaKLke4nkWZUJ6rNVYpapuCvnE4J+Rlj8TL1IVMwyB41RfXo6rYbVn5krZaOuI3PfeqwyFOPb+xNxIMI9vvM8ygZKhcor4OfGYLTKqp4j03772JPiLOT4r05QCaW/vyrNfynmh/xvA2OrzgfY5O8emgO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 17:21:42 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 17:21:42 +0000
Message-ID: <502a79b5-e172-4bcb-a73f-b9d94dcb2d3d@intel.com>
Date: Fri, 13 Oct 2023 10:21:41 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 09/10] tools/testing/cxl: Make cxl_memdev_state
 available to other command emulation
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657721157.1491153.10282227094664408585.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657721157.1491153.10282227094664408585.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV3PR11MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: e86f815a-61d8-4ea1-9122-08dbcc10de28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bruTDFY0eO2WTlu/s5KJQZ0gD47USUIC7h2Pk4f3MLRO/942V/Vacpq2bHqUK5nGNIxWJJ5lH2GQ1YoDxTHnh1xGAhG4AnKnjlcA7iZs2cuZS7NclVXVigxHuFEfrq4FnFn15VKPYVtZxGFdutdO9NiHyddQfQRIMnTSD1HTQ6Q12pwoxea0JeCxN0zCeSIDeZRoT8HJ37THN7VR6w1hc7fFDNkBRItyoBwiqsUssVlYf7neYxeWEOFP9HKjMKJUbTdmZfygnUsidtixWbstXZdjc98+6iPP3U2Pyr/OMYfE07Sb/P0tEcXy22r6fnBGlQDGf1JNxUxgIeeWEz509yM/kqkkxj7E74H4pZqZYVl9Knp8lPC/mtHvZveIAvDSAHxqNG8hmM0LNM3jULlZFq9BnG4zR0qDZCIAEu4EYu6hJtvEFUZDpjc2/h3iDbz6CJsIX4I7ktwa+d56FZ3s1fcSgORUutcOkJdzpgqcDiYSy3gkq1QG3zupGaPCOfnrpZhcNHQq8v/QYMAK84q7hkTmZm0JQfp9ktlSw5XVayWcEj8F42op2hsigIj7OebLuztGdAAsNMgRw7ox5kqopHE1W8RPPgtnxYQzlJotvfRdGxxDu+3MOvJWJ195CuD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(478600001)(8676002)(66476007)(66556008)(316002)(66946007)(31696002)(86362001)(8936002)(82960400001)(2906002)(38100700002)(36756003)(5660300002)(41300700001)(44832011)(26005)(6512007)(31686004)(2616005)(83380400001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNmNU1xVlBRNVNvMUlmWm1MdXJkcEsxNnhkajZ1NU0rUXB3ODlhd1NKNEhQ?=
 =?utf-8?B?NTBrbWJIQ2RZWTloWnJ4amoxSGRyVGZxdkNUdzFwWVlJb1BqbGRybkhOOTlh?=
 =?utf-8?B?dGpKd2tlQ0w4R1ZFcEc0aHg0aVNZbW9Cd3RwcHZHd3VuWWMzMUJ0KzdHM0RI?=
 =?utf-8?B?UDl3MGVkcU16eTIvYjNFTHlUZDVmMFpjUjhBSGJIM2VZUzc3TGlLdUhmbVNF?=
 =?utf-8?B?bW1Ib0tUTXE3YjRTN2ZTR2pMRi8vMk1MSXczQ05EcDVRNGw4ekNLckRUckRw?=
 =?utf-8?B?Vm43MWVlNm5NZEJsRFJCL2RCVmZmMS83K1RadGQ3bzJXWkY0WEl6UTcrL3h2?=
 =?utf-8?B?SWtoQlg1TDBTcmNucFRwRXhKck5sSlpkY3dOMXhOSmxHeXlJd3hzZlVRYnY5?=
 =?utf-8?B?dW9xSGp5MEZmOUhzSlZlTEtrOTh5eUhjVVVRUGJINFlxVUZzSDlaT1NBS21V?=
 =?utf-8?B?RWdCWkxsZmR2Wmh4RUFwZlllVWVPUHVUN3BtclBFbzV3V0RLUVpUUHdIVlA2?=
 =?utf-8?B?U05CSWZubTNuK08yR2FpV2lNMGlnY1NDRmNNZUFKWU84c2c5SGgxVU1Ld2tB?=
 =?utf-8?B?MlN5OFZzUzR1d0dtbTRMWFpOR1RMelBpUG02WkpjQTNDandjMzNUVGVmZFBm?=
 =?utf-8?B?UzRSclBiRGNFOW9nbTdkZm5xOCt1Yk5XWHc0Q1VrcVBsOURKbkc5NXNiRzZJ?=
 =?utf-8?B?NjZTV0tiZzJlRGk3UFNiUDU1TUxhb3JCK2c0SEFBVzh1UFhHNERPRkRwSHFj?=
 =?utf-8?B?ZmlweEU2S2QyeG9OODFuOGNXaDVHTTIxTFh0SDNMbGR5Rzh4Nm0yNFVvUTZ2?=
 =?utf-8?B?UW9QdXYyZTFaMHp1N2FubWxXQXdXTzMrOTJNUlNmWWwzaFhxM09WdXZwNSt0?=
 =?utf-8?B?aXcvQXZIVFFDRm91cG1ZZnV5ZHA0dzFWb29lLzR2YzNCTXM2OWpJcWwweEJk?=
 =?utf-8?B?YWFHR2FxU3RPdWx6RzlpckhYN2ViODJ1Z3N3SnQ5bnppT0VuQWtROFA2MXJa?=
 =?utf-8?B?OXZjNDQ4WlRzRmVFMUh0WGw3WGtISE93eFdZdTBpVEJoSTRQZW00cTE0QitY?=
 =?utf-8?B?Z1BPWlBjYm9iSU8ydnVmOE9wUG12V1A5dm82VCtVV3l3V2w0UXdMbkxDTHhR?=
 =?utf-8?B?LzVjZy9aTVZMWmZNN1VxbFFoY1psVjAwOGM0RklRTWNWa0xFWjNUdDYvZXNU?=
 =?utf-8?B?b0E0N3F2Vm9sOVhDQWh6NjJsTTlWV1RhK2Z0MjFTVlVacVFCTlFLbUpXcDlX?=
 =?utf-8?B?K2RJQ1pOOVVEeFhjZkIySDBBcUFTdHBPUkh0UUFVcmR4YVR1aGtpV2hTN2lW?=
 =?utf-8?B?anhvMUdHR2ZYaDlwaSsvR1phRzVudXkyakpMamdPd1lPQ3ZERGxsaU1WaFFW?=
 =?utf-8?B?cStKRDdLZXcwbGJqV0JSSDJkRUtTeEh3WVd1alh4UmtoRTZEcUtHVHpSS25m?=
 =?utf-8?B?OHhPcHYyNmpTZHRwVm85cjdBZlU5cEUyMkt0QlgwdHhVTGhVSXdHaTBNYS9s?=
 =?utf-8?B?QnBBSDNyTzNVVUxXUnpRSEI5cllYLzErMnNTQ3V0dDA2cDZoWXVwZUZNcEVn?=
 =?utf-8?B?R3dpRG44OVZNQTVZUVl4NTNwZi9hbkwyaGhXUDM0U2JrU2FSelN5VUh0WFpG?=
 =?utf-8?B?Y2RQNCtLYWpQVng4VTlLdUNRckhqUnljWVFnaERZNEtUT1cvWEI2cUg2THhy?=
 =?utf-8?B?d2JBc0h6QURMRkpIL1pCemhaaDBJcVRrbnE3eEdCSjFpZkppME8ydjI0djND?=
 =?utf-8?B?REt0Q2ZwK1VJZ3hiSmFZYjY2NXNObUw3YTRndmtrNUlRa2thV0RJWElxK25q?=
 =?utf-8?B?RnRBR2FyY0IzQldaZ1NKKysrUk5JaGRBbExPOTFYa1IwMzdhcEdOM2xtNGE2?=
 =?utf-8?B?M2NsQk4rZ3c3WWRsRXU3OEVJVy81SzU5dlNMNnBUL0VNa0FGWDBBYTZJb0lG?=
 =?utf-8?B?dVN4RXZOazh5WFB5V0M4WnVLL0xpdlRJYkVlVDBLZ1VTbVdKaE9xdkxtN3dl?=
 =?utf-8?B?WCtLN2hLSGR3NnpXMTByTVErbVVtT2g1aE5kSFFpL29EemM5VHJHS1RoTVh4?=
 =?utf-8?B?dUZ0MlRsVjJEQTU1T2VXKzc0OENURW1xWXZuSXZuNDBwYlQrYk1yMi8zZEMr?=
 =?utf-8?Q?dtpYRTu8AjHZIIqN6i6exCz/o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e86f815a-61d8-4ea1-9122-08dbcc10de28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:21:42.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmTe+OpyiSPOjJ46C1CxVcjvwbItr8zdZvaTLsrU5WAhA/QVL9a3OMvOG6iyMYP06xO9rHkgWIxmKLXLUlUThg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> Move @mds out of the event specific 'struct mock_event_store' and into
> the base 'struct cxl_mockmem_data' directly. This is in preparation for
> enabling cxl_test to exercise the notifier flow for 'sanitize' operation
> completion.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 68118c37f0b5..ab311b59899a 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -133,7 +133,6 @@ struct mock_event_log {
>  };
>  
>  struct mock_event_store {
> -	struct cxl_memdev_state *mds;
>  	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
>  	u32 ev_status;
>  };
> @@ -150,6 +149,7 @@ struct cxl_mockmem_data {
>  	int user_limit;
>  	int master_limit;
>  	struct mock_event_store mes;
> +	struct cxl_memdev_state *mds;
>  	u8 event_buf[SZ_4K];
>  	u64 timestamp;
>  };
> @@ -326,7 +326,7 @@ static void cxl_mock_event_trigger(struct device *dev)
>  			event_reset_log(log);
>  	}
>  
> -	cxl_mem_get_event_records(mes->mds, mes->ev_status);
> +	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
>  }
>  
>  struct cxl_event_record_raw maint_needed = {
> @@ -1415,6 +1415,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  
> +	mdata->mds = mds;
>  	mds->mbox_send = cxl_mock_mbox_send;
>  	mds->payload_size = SZ_4K;
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
> @@ -1447,7 +1448,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	mdata->mes.mds = mds;
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
>  	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
> 
> 
