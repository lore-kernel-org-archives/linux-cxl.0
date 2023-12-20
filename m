Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028804A991
	for <linux-cxl@vger.kernel.org>; Wed, 20 Dec 2023 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS0TuO3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111188; x=1734647188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=98KL/IDwdS6uTihknK6HZZvarKjBd6Nkope48F4EEJM=;
  b=MS0TuO3HxDMKIRs09irBuk7OK22YY0wp2lwCM/N/tHnd0uZefwnaEYim
   ko441r7p/+Azl9UE6GEDMIyVMtIjCG6hex6DKKzkLcrINP9x+YiRCPo+i
   k7rgd1WP3jDNvp58zdECtoqNyaRZcLAc5CAhOA0rW7K/7M6BTdw7q4hY0
   hk5692J506AfQk1vc3SV2wEcAkGtjulj6mEVGvu+4Zim8tSlnTA0E/ftK
   n9PT+KuZp0OdeYlI4mZRglvNZIU7JpeZXYuqPEnbHv+nDPSUwceLfcd+x
   hQN9JgRQYWlkjAbw3SPDyEFsGIDuZK7FLJ1OJQyyPURr68I6SGqUxmWIF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462329867"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="462329867"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023629727"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023629727"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:26:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:26:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:26:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:26:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmgdRARfGg4T9ivT2XQVGQOyn/seiNDcSRCO0/IODnt1bJQIxQWZEyads1nBug6GjRRoPsurtRjzuXZLXI0rPyrOyFuV42uhFwpbN10TcBvu19AhxkFu/uZL13FiZkw9cNfObfZlk2sE3iQJZuR0ivgwYOxRQQS+ZUUoJdzRMgKoD3v28OOSsd/daJ8ZU6vtGpAT+A/QLwKAftzIsW3eUBmFC7TrZ0ChnsjBgsifKVlQeq4IaHvWu6chSaWJDLFHZ1lUSYZXGS8tq3qCC+bg8IGNIOn6sLQbxwKLnIzhu7P/eh/11Qlp89X3cpNC7I5W1eoV91kysRvzXznpPMRBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93zTTxDQ/jp16VUtS2p01J1lcDdXAh8Q2Vyxmz2rxyg=;
 b=hs2K/kCQz+5Fok+wQnwSgzuMCudig89MZSaZ+pWkvpCIN5Rg+c/olyuia9kBIHmY4XzqPa+Lo7387sFACSNH9khVm/BE4ZHQLGVu5bD9J84WIPx0JG3EZhwxRqek7lN5s+rKPQS6ScO6fGZtUdo093Leg3IOwq/38+A7vq8drP+JmnfiKPbeQhpXGvKwhOtYJjZncY+a918pJCFda8DDU96U2DqNPUFJ17dQvGL7McSqaQRXBV7OcDC3gXJR/p/yPgVugV7kpxuxurxtWS6apZL/yuoC1/WUfNef8ejvmeEKimjkpGBDjSs1ahx/CZQ/mrS3qQa1a+ppimI7FyqlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CYXPR11MB8732.namprd11.prod.outlook.com (2603:10b6:930:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 22:26:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 22:26:22 +0000
Message-ID: <2fb48806-ae84-4e6e-82aa-712b4e511142@intel.com>
Date: Wed, 20 Dec 2023 15:26:19 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v14 19/19] cxl: Check qos_class validity on memdev probe
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
 <170248579618.801570.17463788516390290503.stgit@djiang5-mobl3>
 <20231219164221.000011c8@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231219164221.000011c8@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CYXPR11MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc65051-f92b-44f1-1ccd-08dc01aab23b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oa5tntKprjpos1qSCIS/MVIzf7P66ql+NzgaWToiE2qJo96iCwkREjVTgAV04iFDLTBZJv3JUygUPnawmFjnANlH+e7a3Zfbpt2GwA/Y2ZSSTzNpUQEBUbs6Z5lv9jANf1ATD8VRa3cai1S9KXShN0yT/6FLhc/CR+ISuE/4ZqmiP1Cmr5B3Jq1CG3xXy7+/1dp3C2I0eHuUi5aP4NDRqFBzeb08OY+qO5FxLliPo6VytGuXIc4HNYgey9abfX7MqE1ENNMVCk/XpXskSwkDj1CQ4eQVlqpgHO3IzgfHvTiTow9/3UEFtGZ26dibP2CfZc6oEDFUemL0fQ0t4+mOTFtXP+ks5Mb5eIXa/TITtHUqOaw5GltEE4yioDJyxuPpeqMmk5cpgoSkIcai+/KfIygCxTF0ciLhFOQKgV50sXlkzfoa2EYW+S0FW7qN33xjENk60SD+iNmNRShle80GUt43SRlvtqkmR4/YiMfx+grqu641Ik/mVaXhtIIxzx+GpHzDs5hbTXoMfeSnKLkJsXXyyENO2rTzx7Sq59gG70LnWlzo0rJ4c+X/zFXNHWleCw6cFSCctz/qsWIqOGIC4OFh1flN9XEtRpfz2ri8UeHL6VBqK+ivpFmZZLbSD8vH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(38100700002)(2906002)(86362001)(36756003)(41300700001)(31696002)(316002)(66946007)(31686004)(6916009)(6666004)(66476007)(6512007)(83380400001)(66556008)(2616005)(478600001)(6486002)(6506007)(26005)(44832011)(5660300002)(53546011)(8676002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2V6ZDJsRUJuZkJ5ekV2QkZ0RDNRUUJ2MHZLRVNlY01FaklvZ0x5SUNzSVNF?=
 =?utf-8?B?dElvdXJlSEdFdFVES1F6YXFDZlAyUVJsWmkwVXlaWWdFUXhHOHN0aCtOWTFq?=
 =?utf-8?B?ZlI4ZngwUzAxbDRoeVlGZVpLRGYreE5kR2NuSlFJMVA5S3VkVERkVW1mcENT?=
 =?utf-8?B?cW84aGNXa3hjd2o0QUFoeVVveVJ5VWRRNWl0YkRCVUVKcTErSkpVNXNBS245?=
 =?utf-8?B?ZkszL2JpeTZrQXAyaUR3cnZJcFErS0gzY2IvdE1PWXAvTkZlamNIK3YyK21x?=
 =?utf-8?B?U0lEZ25kTHowSmdKRjBKU2FkblVsRnRLY1ovRkMxM3ovV3lweWlpRWtEN2t4?=
 =?utf-8?B?UGtYWmRVUWxtdC9GR2ZRSW4vV0paWUpvSDVRTysvcThqK0x3MVZ1MkpOTDBT?=
 =?utf-8?B?YXZDRkpBbTZQMmdUdEt2QXFsQnZMbjVpakhJYm9KVG1Ld1JvRHUwVmx2YkZK?=
 =?utf-8?B?RE1oS0Q2cS9KUktyN0l1SkxnNVYrenBVVWN6VHVHcjYvRTRjbGlBR3Z3K1JK?=
 =?utf-8?B?cTBqRGxiS1hqSFlLOFViWWhvbHBRM24yZEdqRDU3MWw3N0dWalVXUFluRE1Z?=
 =?utf-8?B?T3dPVUVvZHNCRWl3V3haKzV2a3lYOFluWFJxRDluTjZaR0lqZ2x1NlRxQ1lY?=
 =?utf-8?B?U3JMTHgvMjlxZjBMOVZLckFMaFJvVCtmOC92VDBMLzI3RkxneGRTQlZlelF6?=
 =?utf-8?B?OExaMnluejJzQWZwVnpSRlZmazVnblN0alM0NkRUKzV4N2lCdXM5NmZvZGRY?=
 =?utf-8?B?YUp3aGZMQXlIVzRuc3lQczlabS9ka2ZCVnAyNDlxdDk2TkRrUEgxNC9ZSXEr?=
 =?utf-8?B?YWhaWHJsTFBCTy9xcmdVb2l4M01JTWpNL0FHalluZmtQckxIQlhzcEZLQ2dI?=
 =?utf-8?B?bDFHVHdMZ3dhR0FaM3pVVC9ZcmdIT3cwQUhwMmxCWHJYbWlxeW8vRnpYL0ZP?=
 =?utf-8?B?MFhDYjluNG1MdUZzcDU2Z24zU0JmWDF2UjVhaHZKdk9walQxR2RCdjc4OXBi?=
 =?utf-8?B?MHhocTJ5Q0RuNGJZelNtT0FheEdqQWpiVVhCd05yVisyNzJ2WENpbUNYeStk?=
 =?utf-8?B?Y1JEVEMwb3UzcjRaZGMzdWxKZG1RM3VGdkRIZTBPOFgySjVJZWZBVHVxbTZX?=
 =?utf-8?B?a1M4VktjQ281bFo3M0dGTG9NSjRVS1B5ejd0eFNGUlFrOFJLMmdZTGY4bk9E?=
 =?utf-8?B?dWc1Ny9HWVhuNUlqUmN6Rk1jajBsTmtyQnhZeW5BOGdRWmpVUUsrbWlOSnBK?=
 =?utf-8?B?SEVCb3RjbGZVYTlkOFVEbmU4Q1lyQm8raXVZd1VjbEdQRGRJdjR1NFQzQStk?=
 =?utf-8?B?T2dWbDJBWm9KNko1clpmTmRrd1IwT0Y5UFdmTlMwR2ZZQ2pBSHlRR3F5RENw?=
 =?utf-8?B?RGRKV29xdDhrT1pERmFQRFU3VUp0ektKNVIvT1l3WDZ1SDhJeVM0S3dWR1hJ?=
 =?utf-8?B?U21nRER0MVA3WEJJUjJETlBEYk9zbmNMRXl3dk0rQWxJVGc1Smt6RTErc0gr?=
 =?utf-8?B?OXVMWjdBMFZJUzdIOWY3ODh5dlh3eDR6T2ZhenFNakYwZDVaSjhzSUcyNTNX?=
 =?utf-8?B?RmoxV3h1QmlzRDQ3NmZIZ1lEZVMwR1lWR0daay94M0MrbHpBUHpqU1VET0Vn?=
 =?utf-8?B?Z1poeGt3aGpUTGJvL2ExL2JYYlFmZ0pJTUlheDhycFptQlVjbm11dUpYcWtr?=
 =?utf-8?B?NEhJb3lMNEo2a0g2UW9kT2J2TkpqL0xkTmNkbkR1WVN4SW00K3dzL0Z1RWw0?=
 =?utf-8?B?SThwYUlSbktIRk1keHBLNEk5WnhzTVl3MjJuWGFrNlplNyszWUhvNTlMSGYr?=
 =?utf-8?B?RGpsRzQxcFRlZTVNU2hacHpudmY2OXlwUGEvS3Qxb2s0MEVWQ2Y1alo3RS9T?=
 =?utf-8?B?WUNadlU5T3dTQWdxbXJVTmRaRWhpYm5ycWZqOXJSN24wYTJZRWpSMjFIcmJP?=
 =?utf-8?B?a0ZHcEwwTUh2S0tiRi9mZG51UnRjQkFXY21JMFJtMSs0RzNEd0VTS3hySzIw?=
 =?utf-8?B?cDlmZ2xzNFdMaU9hc1ZUVWJFTzM1bFVOZmZ6SmRPYmMrZm1TZVFMUDA0bCtQ?=
 =?utf-8?B?YUpmSUN1KzhESzZ2ZnN2QzJLbEs2bGYxNkxoL0ZKN3ZSTWkrZG1JaXRSRkR2?=
 =?utf-8?Q?drpx0vbPYA3KUer0JO2SR97vb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc65051-f92b-44f1-1ccd-08dc01aab23b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:26:22.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7Uiue0xN+NS7DbBVQ+Sdi1JzkvyV25X7+Zf2H0du23p0mT4uweZJne8fPviELM57FwPfV4uzylxc1cWz2Tu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8732
X-OriginatorOrg: intel.com



On 12/19/23 09:42, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 09:43:16 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a check to make sure the qos_class for the device will match one of
>> the root decoders qos_class. If no match is found, then the qos_class for
>> the device is set to invalid. Also add a check to ensure that the device's
>> host bridge matches to one of the root decoder's downstream targets.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A few comments on places I think this can be simplified.
> 
> Jonathan
> 
>> ---
>> v14:
>> - Move unmatched entries to discard list (Dan)
>> - Update perf_prop_entry to cxl_dpa_perf (Dan)
>> - Use DEFINE_FREE() in cxl_qos_class_verify to clean up code (Dan)
>> - Move qos verify to core/cdat.c in order to be called before region setup
>>   (Dan)
>> ---
>>  drivers/cxl/core/cdat.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 137 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 8c561f1deec6..5fe57fe5e2ee 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -270,6 +270,142 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>  	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
>>  }
>>  
>> +struct qos_class_ctx {
>> +	bool matched;
>> +	int dev_qos_class;
>> +};
>> +
>> +static int match_cxlrd_qos_class(struct device *dev, void *data)
>> +{
>> +	struct qos_class_ctx *ctx = data;
>> +	struct cxl_root_decoder *cxlrd;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
>> +	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
> Why check this one in here?  Caller should take that out first.

Ok I'll move to caller.

> 
>> +		return 0;
>> +
>> +	if (cxlrd->qos_class == ctx->dev_qos_class) {
>> +		ctx->matched = 1;
>> +		return 1;
> 
> As noted below, this is the return value for the device_for_each_child()
> so can use that instead of needing ctx->matched.

Yes. Will simplify.

> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_qos_match(struct cxl_port *root_port,
>> +			 struct list_head *work_list,
>> +			 struct list_head *discard_list)
>> +{
>> +	struct cxl_dpa_perf *dpa_perf, *n;
>> +	struct qos_class_ctx ctx;
>> +	int rc;
>> +
>> +	if (list_empty(work_list))
>> +		return 0;
>> +
>> +	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
>> +		ctx = (struct qos_class_ctx) {
>> +			.matched = false,
>> +			.dev_qos_class = dpa_perf->qos_class,
>> +		};
> 
> 		as above the dev_qos_class doesn't change so can we not
> 		reject it early here? 
> 		if (!dpa_perf->qos_class)
> 			continue; /* I think? */

Not sure what you mean here. qos_class can be 0.

I ended up just changing it to this:

static void cxl_qos_match(struct cxl_port *root_port,
			  struct list_head *work_list,
			  struct list_head *discard_list)
{
	struct cxl_dpa_perf *dpa_perf, *n;
	int rc;

	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
			return;

		rc = device_for_each_child(&root_port->dev,
					   (void *)&dpa_perf->qos_class,
					   match_cxlrd_qos_class);
		if (!rc)
			list_move_tail(&dpa_perf->list, discard_list);
	}
}


> 
>> +		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
>> +		if (rc < 0)
>> +			return -ENOENT;
> 
> Can only return 0 or 1  and 1 is returned only on a match, so can use that
> in place of ctx.matched if you like.

Yes I will remove ctx.matched completely.

> 
>> +
>> +		if (!ctx.matched)
>> +			list_move_tail(&dpa_perf->list, discard_list);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +struct qos_hb_ctx {
>> +	bool matched;
>> +	struct device *host_bridge;
>> +};
>> +
>> +static int match_cxlrd_hb(struct device *dev, void *data)
>> +{
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct qos_hb_ctx *ctx = data;
>> +	struct cxl_root_decoder *cxlrd;
>> +	unsigned int seq;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +
>> +	do {
>> +		seq = read_seqbegin(&cxlsd->target_lock);
>> +		for (int i = 0; i < cxlsd->nr_targets; i++) {
>> +			if (ctx->host_bridge ==
>> +			    cxlsd->target[i]->dport_dev) {
>> +				ctx->matched = true;
>> +				return 1;
>> +			}
>> +		}
>> +	} while (read_seqretry(&cxlsd->target_lock, seq));
>> +
>> +	return 0;
>> +}
>> +
>> +static void discard_dpa_perf(struct list_head *list)
>> +{
>> +	struct cxl_dpa_perf *dpa_perf, *n;
>> +
>> +	list_for_each_entry_safe(dpa_perf, n, list, list) {
>> +		list_del(&dpa_perf->list);
>> +		kfree(dpa_perf);
>> +	}
>> +}
>> +DEFINE_FREE(dpa_perf, struct list_head *, if (_T) discard_dpa_perf(_T))
> 
> Can if (_T) ever fail?
> The list can be empty but I think the pointer is always valid.

Right. I'll change it to if (!list_empty(_T)) given here we are pointing to a list_head on stack.

> 
>> +
>> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct cxl_port *root_port __free(put_device) = NULL;
>> +	LIST_HEAD(__discard);
>> +	struct list_head *discard __free(dpa_perf) = &__discard;
>> +	struct qos_hb_ctx hbctx;
>> +	int rc;
>> +
>> +	root_port = find_cxl_root(cxlmd->endpoint);
>> +	if (!root_port)
>> +		return -ENODEV;
>> +
>> +	/* Check that the QTG IDs are all sane between end device and root decoders */
>> +	rc = cxl_qos_match(root_port, &mds->ram_perf_list, discard);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* Check to make sure that the device's host bridge is under a root decoder */
>> +	hbctx = (struct qos_hb_ctx) {
>> +		.matched = false,
>> +		.host_bridge = cxlmd->endpoint->host_bridge,
>> +	};
>> +	rc = device_for_each_child(&root_port->dev, &hbctx, match_cxlrd_hb);
>> +	if (rc < 0)
>> +		return rc;
> As above failre sure this can't return an error, and I think you can use the return
> value == 1 in place of the matched variable allowing simpler context.

Will simplify

>> +
>> +	if (!hbctx.matched) {
>> +		list_splice_tail_init(&mds->ram_perf_list, discard);
>> +		list_splice_tail_init(&mds->pmem_perf_list, discard);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
> 
> 
