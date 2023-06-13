Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F22EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 22:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjFMWJ0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMWJM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:09:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEE1FCA
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686694120; x=1718230120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+z7JIAyIA5LkDkwq0d0EfDMkI1TWBoAJ1wyiv3Ycyo=;
  b=EZGPeUEOABDd97uOjQ3plcYIxUXtnSklwPe9sG0EOzCuh7kOKO5HjVNn
   sSz83COyxyNiMqNeQwKERdLzwXLhF3OrTggke9VLog0KubL5u7CmdKvJu
   LRZoq45r+Q9LFwa6sY0tju+G1Uy8gyzcWTMlIV2RoLyniKNc+2o88tQzL
   q8UHEXro95lgS2ZcDywtSiarkT3sGylaZ/csbblLtfUHRUCRIQwzqb/In
   RH3/i9zlOLuWRPQ5M0oc2ZduCShL5TrYV7Z19iwksUnhnttV/p0NwlD7m
   F30R/X/ESgY8YkuRmauAUyQDtjm4AnCDGKRIkr9lSrI+tbKHNJIEdm7Fd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444835713"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="444835713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711805768"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711805768"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 15:08:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:08:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:08:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:08:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3AYQSgYL10uQXRoNeQo9HiGiR3AteXWk8pyHrAv0IqytfI45htczqPIYqIH7F0CSFl8lgExveHNU8+VF0D0f6d0+8ut+TMhb+rebWsEhcObtwmFSDqk2To/vf3RERVQLWI6w32gceoZ4GcTk/CsJgK3n9C5mAKab9xnpYs25O+Ju6v6XKpuywzhxtK84+N75T9sCNDmgfYa+hzuNSzhcYs8F4PhYSwsHcytXpo2RaSiUM/3m9/iKHxvJXWdd/EkhJhQ3LNFXkJcVVtUvDMPqgxhtlM2WR1f35hb/K8YaUh9mlJCQ/hJHjujkQJJ0GZwq0zib5X94ycGRG960p+OcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSVjI97xk42TueL485QSJss6ABjM2YviBuZM5AVvIlI=;
 b=LaoROaRdaf4IR6uN5vJTJdw8CO+7Q0ajd/AXUoFWB+CLZJQKnT9dOX9UC8Ntb8E8YZ1QjvsIIDZztI6JrLGeoddvkQ3p82g9tIBiSd3Tbk76WKhEYKM7kiJfgbAySwtd++kIkKEuXSgfXh6mCbklF0hghLu19q90VTb1NOHaekVixPLvpgbo9SYh7UHhVj9X+lkz8crkGiW4sQYEbTYqx06MRDRESsO3frxTlW4oGEc0ACte59bWt2KwTshqQcd+fxNeGVivR3/0eYyA0S8LZLArqTgFyWePqUMHbLuEtDgkofeqFu9zIHv9znuK3l5XxDbFdWXPIIcgdn1V0pNNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7422.namprd11.prod.outlook.com (2603:10b6:510:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 22:08:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 22:08:36 +0000
Message-ID: <1add648c-9b80-03e9-3579-8ae0aaa2056b@intel.com>
Date:   Tue, 13 Jun 2023 15:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 02/19] tools/testing/cxl: Remove unused @cxlds argument
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592150866.1948938.14035429174747236697.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592150866.1948938.14035429174747236697.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1cd032-0a6e-413c-ef2a-08db6c5abc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BAT7nb0s/freZmL9jxOKXWqRSpXR+r4oI0VSib6mlVaFVqABgUzWUG9ITiI1RfWQpTuFc0GwAdws5OxcYKpiqc5hHrDUVTeMO76beQw4hsXg2y+wtQvdtHqtto9Y6HKwnD4ayfbm4fxWDomOSioH2jsHVweMo1PDBYYqhS52bBQ0y2TzHZYvwzhNbX16mNIFbPOUbCqPL0AyUF5p8OHciRJS4pqx8kTZ/f91mekBWTkAs3FxAR7jX4SvwdNpTPTPlhRnqCjXLwj3an20Mm25K/0M2+O7grgh4jDbSfjGz0HLp77rmAhuZGxbNMJxYXBVtPcZv7lcOY3DWkhdUVa7PG9wvf2JWsksVb7yBpS+czmg4ueSmgyEBzyeYQu4v00aOiDcrY43nseMyCYPXyqq3qGzcBNi+PpmoltLLUAbEeCFVFW1GRTWxBqjEzAMiJuuQa4A5eNeQqbZG2cY6yRJVCHOJWx4bAHXFBgUbnGuEagCA9aOeZjrmO6GXv5tor3rkIDJqomPNzLePoo8Cxkt8hKWJwxXLuKEFKmiQ1FEaufLRw+l+2O2gqGNDgPCc5cude7PMXW5tfbUYeLRc/+ZDEr+bOsNIl2Me1uZ4cDVpuLgv1IoCCLKuBkTyKKSxV86pmYR/xtl0yxNmtIFh1Okg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82960400001)(86362001)(31696002)(36756003)(38100700002)(6486002)(2906002)(6666004)(44832011)(186003)(53546011)(107886003)(26005)(6506007)(6512007)(316002)(66946007)(4326008)(66556008)(66476007)(8676002)(478600001)(41300700001)(5660300002)(8936002)(31686004)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3MyZ2c2aDNjc2xVblhUTzVWdFR5NVNNUXV2MjZ0Mk5JUUxYTFVPL0pQU2RO?=
 =?utf-8?B?RnVBd2lBcWFCUXlqTkt4d09NNCt2c1VoNkhUOW5xY0x5V3VmTDI3NnZpWnBL?=
 =?utf-8?B?QlhPUmNrK0tneDRnbWRwUC8wQWN1VUJHYnp6bE5xVERCczFMYUkySzc4TE1M?=
 =?utf-8?B?WFpzc2h0UktFVEp4djRXcUxFS3RvMjVyNkN3RVJ4MmFPOHNOUWZiWGpia202?=
 =?utf-8?B?MmdlRzUxMnVWM1ZBL1kva2JNVGlKYUVXU1JnYmVucnBtZktreVFUYUlLVlpi?=
 =?utf-8?B?K0lqbTdlREtGaXVKN0VMZmV3VVJ6cUp0UUFJSUJMM0VUOUV4bEFzTHhXdkh3?=
 =?utf-8?B?SzkyYXVPSXFwT3psSjZ5WThoZ3hGSlFnaTgxcjJhR3htNWNRNis5b0RrenZk?=
 =?utf-8?B?cVBYRVA1b0E3aTkrMUtvNXhFR0NGS2hDQjViTFdTVXg4WHBER3djWFgzUDhI?=
 =?utf-8?B?WnAyOGFPUTF3Ylh5ejk4ZGtPLzJ5U1ZTT0s2NzZGK3pBUVRLZXp5RitocmN5?=
 =?utf-8?B?Y1h0UDJOMWFrL2FQZUloc3lOKzJrOXZmQ2h1aStRNE9TYWhmYWN0bW42OGNG?=
 =?utf-8?B?V3VlYVZQVXN3SHRqMzF3NjIxMDhPZ2lSYjhZVzdHTFZrL2hjWUdML0lSNEZY?=
 =?utf-8?B?MGVVc0pFYlpRd3EwcnRiVUg2TEtleFFWbkZvUkd3WE1aUEQxaks0akZHS3VM?=
 =?utf-8?B?Rmlib0dIcU1UZ2RIOTVSV0NaaTNWNzMyUUpYMVJQV1phY1NZL3o2NW5pU05J?=
 =?utf-8?B?MTNGbUE0UC9lS01UUFVCTUxsVzVRU1FZVFZjTTB3K3UvK0s2ZUNTbm12WTNt?=
 =?utf-8?B?cDVwaERwNmNpUUptQzg3ZmliSWt3NGFtY1ZWVWdzQkdzWGlGQi92N2lmM2RS?=
 =?utf-8?B?RktXMTdBMGZHMkhQUk1JQ2ZGd295OFhPTExSWmZmMTFMVmxlUlBsQ29ESWxo?=
 =?utf-8?B?bGhUUjVrc2daYTVXdm5LU1hmMXNZMm9iTkVvVmVJMkxjTVpNczJSUTVUM1NN?=
 =?utf-8?B?NjNhcnpYb3NMOE9Td3g1eU1hd0lKN2x6UHZ1WTRJTmpvRjlEbHRZWTF6djVX?=
 =?utf-8?B?UjVpbFF3NFp2ZkVRVSswRmUzeXlqT3dpUlllRTA1czJEbWZTbU9qYm9tRUlm?=
 =?utf-8?B?Z0pzY3Rrb0FJUDJZS0I0bWh3aTJReWFsMjdwaXcyLzAzSTk5OTkvUkZXRHcr?=
 =?utf-8?B?QkxDWmxYNjhONXh1a1poWDVtYlZXRTF5YVVJUWNwR0hEL1VNbzNzQVpKR2h0?=
 =?utf-8?B?QUZtaW14elBFaWE5Y0RHYnBFL0JFT3R5ZG9OMTV6MW9pYllmM0tKZFQxOHcw?=
 =?utf-8?B?dGxvSVAyUDcvejZlQ2NwTER6b3ovbEhHY3Vhc2VqZ0ZKbDdMVFovNmovZDhY?=
 =?utf-8?B?VzVYeFZ2YVRncWlBOUxRYUs4Uk1iUkIzN1hXdWRPcU51bnk3cEczeWZKbFFJ?=
 =?utf-8?B?cTVkN1JzbWZRb3J6eS9wcVFCUnd3cnBnVkhaeTNidHQwa3dya1JwMnRNV0I4?=
 =?utf-8?B?SG5GTnFkcEJZY1ExVzRnMHNqTGVBUHM5TTZBajhyMDNuWUlmT1VvOTdMM0ZC?=
 =?utf-8?B?VXhWM0FBdmpic0cwdXdJd0QxUzF3MXdudkNJbnkxM3J0YkViVmo4OFQwZlUz?=
 =?utf-8?B?WFduR2g2ajF2dmU4RjNiaXliTE9aMVZDM3Q0QVJpRXNkZk9lYytYUFpiemkz?=
 =?utf-8?B?Ti9VSHhueDhzS0JRZmZ0SUFTbWgvWnMvRlk4MDdTWGhvZDBySTZUbUZxT24r?=
 =?utf-8?B?RDJMSld0WktnZ2U1bWJWMVdMZlBQNGZhQy9IOE5FUElGWWVqbSsxaWE5NlBJ?=
 =?utf-8?B?ekh6V1BEWmhETTZicVFxaGVLWHA4K0thcE14TTZ6UG9nbEFFemw5NklvSGVY?=
 =?utf-8?B?VERKWkNVWmdIVTdFNEovbE5Fb0lRTjZ1RXAxU29oMWhTVlo2VzJ1RVF3VWZF?=
 =?utf-8?B?cTdXRDFNZWFicXh4eDJ6L0QvMUcyY2t5UG54Snh1VXNMRTlJOXlmMnJQZGs5?=
 =?utf-8?B?bG1CMUQ3OU92T284Z1Mzc3gvUUNuUEw5TjMwaG1GZHVSMTRPVXVtMHFCdUFU?=
 =?utf-8?B?SzNxVVpsaXFFdkFIcTRZaCtQR2JzRW9Qb1JoM0orNzFwVFJHQWFDWmZLZWw4?=
 =?utf-8?Q?tg00qJdwp7f7JJ9ITEouT6yJk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1cd032-0a6e-413c-ef2a-08db6c5abc1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:08:36.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svCl+gyDmd8cz57dtvIERLq9U0NryD3K/TlGewaQ0LdCP0HBrpsIQet6qibcpkVTNnVQBVle0bhxdUlAqrxtJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7422
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:31, Dan Williams wrote:
> In preparation for plumbing a 'struct cxl_memdev_state' as a superset of
> a 'struct cxl_dev_state' cleanup the usage of @cxlds in the unit test
> infrastructure.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   tools/testing/cxl/test/mem.c |   86 +++++++++++++++++++-----------------------
>   1 file changed, 39 insertions(+), 47 deletions(-)
>
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 34b48027b3de..bdaf086d994e 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -180,8 +180,7 @@ static void mes_add_event(struct mock_event_store *mes,
>   	log->nr_events++;
>   }
>   
> -static int mock_get_event(struct cxl_dev_state *cxlds,
> -			  struct cxl_mbox_cmd *cmd)
> +static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_get_event_payload *pl;
>   	struct mock_event_log *log;
> @@ -201,7 +200,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
>   
>   	memset(cmd->payload_out, 0, cmd->size_out);
>   
> -	log = event_find_log(cxlds->dev, log_type);
> +	log = event_find_log(dev, log_type);
>   	if (!log || event_log_empty(log))
>   		return 0;
>   
> @@ -234,8 +233,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> -static int mock_clear_event(struct cxl_dev_state *cxlds,
> -			    struct cxl_mbox_cmd *cmd)
> +static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
>   	struct mock_event_log *log;
> @@ -246,7 +244,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
>   	if (log_type >= CXL_EVENT_TYPE_MAX)
>   		return -EINVAL;
>   
> -	log = event_find_log(cxlds->dev, log_type);
> +	log = event_find_log(dev, log_type);
>   	if (!log)
>   		return 0; /* No mock data in this log */
>   
> @@ -256,7 +254,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
>   	 * However, this is not good behavior for the host so test it.
>   	 */
>   	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> -		dev_err(cxlds->dev,
> +		dev_err(dev,
>   			"Attempting to clear more events than returned!\n");
>   		return -EINVAL;
>   	}
> @@ -266,7 +264,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
>   	     nr < pl->nr_recs;
>   	     nr++, handle++) {
>   		if (handle != le16_to_cpu(pl->handles[nr])) {
> -			dev_err(cxlds->dev, "Clearing events out of order\n");
> +			dev_err(dev, "Clearing events out of order\n");
>   			return -EINVAL;
>   		}
>   	}
> @@ -477,7 +475,7 @@ static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_rcd_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_rcd_id(struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_identify id = {
>   		.fw_revision = { "mock fw v1 " },
> @@ -495,7 +493,7 @@ static int mock_rcd_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_id(struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_identify id = {
>   		.fw_revision = { "mock fw v1 " },
> @@ -517,8 +515,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_partition_info(struct cxl_dev_state *cxlds,
> -			       struct cxl_mbox_cmd *cmd)
> +static int mock_partition_info(struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_get_partition_info pi = {
>   		.active_volatile_cap =
> @@ -535,11 +532,9 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> -static int mock_get_security_state(struct cxl_dev_state *cxlds,
> +static int mock_get_security_state(struct cxl_mockmem_data *mdata,
>   				   struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> -
>   	if (cmd->size_in)
>   		return -EINVAL;
>   
> @@ -569,9 +564,9 @@ static void user_plimit_check(struct cxl_mockmem_data *mdata)
>   		mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
>   }
>   
> -static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_set_passphrase(struct cxl_mockmem_data *mdata,
> +			       struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>   	struct cxl_set_pass *set_pass;
>   
>   	if (cmd->size_in != sizeof(*set_pass))
> @@ -629,9 +624,9 @@ static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
>   	return -EINVAL;
>   }
>   
> -static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_disable_passphrase(struct cxl_mockmem_data *mdata,
> +				   struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>   	struct cxl_disable_pass *dis_pass;
>   
>   	if (cmd->size_in != sizeof(*dis_pass))
> @@ -700,10 +695,9 @@ static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_
>   	return 0;
>   }
>   
> -static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_freeze_security(struct cxl_mockmem_data *mdata,
> +				struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> -
>   	if (cmd->size_in != 0)
>   		return -EINVAL;
>   
> @@ -717,10 +711,9 @@ static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
>   	return 0;
>   }
>   
> -static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_unlock_security(struct cxl_mockmem_data *mdata,
> +				struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> -
>   	if (cmd->size_in != NVDIMM_PASSPHRASE_LEN)
>   		return -EINVAL;
>   
> @@ -759,10 +752,9 @@ static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
>   	return 0;
>   }
>   
> -static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
> +static int mock_passphrase_secure_erase(struct cxl_mockmem_data *mdata,
>   					struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>   	struct cxl_pass_erase *erase;
>   
>   	if (cmd->size_in != sizeof(*erase))
> @@ -858,10 +850,10 @@ static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> -static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_get_lsa(struct cxl_mockmem_data *mdata,
> +			struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>   	void *lsa = mdata->lsa;
>   	u32 offset, length;
>   
> @@ -878,10 +870,10 @@ static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_set_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_set_lsa(struct cxl_mockmem_data *mdata,
> +			struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_set_lsa *set_lsa = cmd->payload_in;
> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
>   	void *lsa = mdata->lsa;
>   	u32 offset, length;
>   
> @@ -896,8 +888,7 @@ static int mock_set_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_health_info(struct cxl_dev_state *cxlds,
> -			    struct cxl_mbox_cmd *cmd)
> +static int mock_health_info(struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_health_info health_info = {
>   		/* set flags for maint needed, perf degraded, hw replacement */
> @@ -1117,6 +1108,7 @@ ATTRIBUTE_GROUPS(cxl_mock_mem_core);
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>   	int rc = -EIO;
>   
>   	switch (cmd->opcode) {
> @@ -1131,45 +1123,45 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   		break;
>   	case CXL_MBOX_OP_IDENTIFY:
>   		if (cxlds->rcd)
> -			rc = mock_rcd_id(cxlds, cmd);
> +			rc = mock_rcd_id(cmd);
>   		else
> -			rc = mock_id(cxlds, cmd);
> +			rc = mock_id(cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_LSA:
> -		rc = mock_get_lsa(cxlds, cmd);
> +		rc = mock_get_lsa(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_PARTITION_INFO:
> -		rc = mock_partition_info(cxlds, cmd);
> +		rc = mock_partition_info(cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_EVENT_RECORD:
> -		rc = mock_get_event(cxlds, cmd);
> +		rc = mock_get_event(dev, cmd);
>   		break;
>   	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
> -		rc = mock_clear_event(cxlds, cmd);
> +		rc = mock_clear_event(dev, cmd);
>   		break;
>   	case CXL_MBOX_OP_SET_LSA:
> -		rc = mock_set_lsa(cxlds, cmd);
> +		rc = mock_set_lsa(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_HEALTH_INFO:
> -		rc = mock_health_info(cxlds, cmd);
> +		rc = mock_health_info(cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_SECURITY_STATE:
> -		rc = mock_get_security_state(cxlds, cmd);
> +		rc = mock_get_security_state(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_SET_PASSPHRASE:
> -		rc = mock_set_passphrase(cxlds, cmd);
> +		rc = mock_set_passphrase(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
> -		rc = mock_disable_passphrase(cxlds, cmd);
> +		rc = mock_disable_passphrase(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_FREEZE_SECURITY:
> -		rc = mock_freeze_security(cxlds, cmd);
> +		rc = mock_freeze_security(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_UNLOCK:
> -		rc = mock_unlock_security(cxlds, cmd);
> +		rc = mock_unlock_security(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
> -		rc = mock_passphrase_secure_erase(cxlds, cmd);
> +		rc = mock_passphrase_secure_erase(mdata, cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_POISON:
>   		rc = mock_get_poison(cxlds, cmd);
>
