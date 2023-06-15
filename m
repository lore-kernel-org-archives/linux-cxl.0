Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6451EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjFOVhS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFOVhQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:37:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C39296E
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686865035; x=1718401035;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HoSkzgn6qd2iRdzxDjln/uZik/z/S90lRAYQdQGBnys=;
  b=TrynjqBumMLyMbo6BcYBWEeGXJty9M6JkXJW0Gkx8hX4pZAPSSKdXzLl
   ZSRT34XTMeWCEqcoxNkm0crhLZJSDNtav0MlcwJ9Ga2f9XeadGqv4IWrJ
   aRhp8/HGugfpCVzbSXKfcFRURlpEabJrmeVAYNYsQRsNMgx7AL263Bk1U
   IIQRTagjnEOxky5SsigV3FZRfhVde90Cn4hPU0vifPDgCXUs26pHA8AV+
   XdAkusPj1PRyhdWadzCSmUzLgbYu30uMHKX7CndVGxwW2xsrMwcOW0cGF
   5vH1FBikf/MBkG2MBoY5OPunr8h0KfrjRxTs0mp5asuEqVuptd9PJSGQ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387644319"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387644319"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777896614"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777896614"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 14:37:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:37:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:37:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGyaIpIStoIIKv+KbyqaJGHuquyJYE+NelUyJG26mTvR9tLvk2rrIF0AOn+B+Bh+Aq/Peeiyyy6zCNktZJDGuYw5dKjYNp2GIbHYeZKJYeR6ditjq+fduxZn+KA6XaD+IP5a78OlJAmFTT/clDcATvDUscmqUtJda0JfGdvgzJ0Ym0UOHtqzH2eB9lA6kmEKg01eaKIUzyz/jAxvQ94q8Dgq0ZzVlrt2XlBQibbBZdl0kNWAJf34LpWkpKGpP3dSljgPpaZWJ83pRSJ5k9OdIPqQ5TRafemkJuTS9N6Ty4eOmK3V4/QQp3SzKZR+ieZdPi+NsDMBbbuHVIm835wW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWWI6FvwTto1sOtWhNlob0D9054ee95ZoLZZm45j/uM=;
 b=O1hYfO3lz1oIzQ90CTxhsUnVQG5taWzkyCFBvvO2iH83tXU8wC98DkzNGR/GKlcB5dGIziFyBDfJLj/AYgClmeCXnUpmMQDcj0x33pnZtdJY8WeKHaSG/SbvelWuSDma8fW6HNNOHz1PP6LUtNXgrTX5cTIKA2uj9FHcWDjAwvh74+L/BFLgDsZgtQ1qbEHWwMHGlU5fnFWseuCQyK2fk1ojlx4eEisptFeVbyaFM71ceh65Yk4mUgA+YrdtlVzlZgSpQEADJ2rcaQwCdq1vfqaVlj7SJd8iSOtoUDydukQkqpIsL01qDseVWxxiSc0zvx5i0Mz2CCw/PjSi95lTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 21:37:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:37:11 +0000
Message-ID: <cc9a65cf-7766-91fc-201d-35dccb64c957@intel.com>
Date:   Thu, 15 Jun 2023 14:37:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 11/12] cxl/port: Enumerate cxl link capabilities
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd52036-0986-4868-98eb-08db6de8ad4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05Z0aHQNh2xvaKeA4tjaLlvTnC5MkwTJOhyF/i+h1JAnjCXqafR8BOTXxHRqvygVW4FLhOlaRiO3XSX84Qn0CKVW94Z+0KjkiGQ5RUdQYYC5+H8w+jF0UyZR6OMVPI3+1+3xX/FMAmP++QoJH3K4tFJj6NqaOc9I/oK52eMoZNGU+gOo7Lab1gcg054JP/ptWMj2oykMgBf086qL/UsLfrFXHoHQbKUw6WO3kwBotKHkBfEwYzB3aNssv7yUdL+JwCQTVT+7c+yA4Q+lz5stjDqW8nCh1rrVE/yQe5NM+Ax4h3KFPpLY6/SeRmVQrjNQNw5jBipE9IzBqcYvP7cmOwoe8P8zYOtWizKKsSmRxzSrjhjVXRjG4Gh1Rsfh4EvJu+d9VOo8O8IFwQytUXE+cPweL58uyRhywV3M5a2gB3q0VV9lkvyC/ZWGA208HsQH0iM3Sx97ZPj2GjCBBL7v4xbSEpssWcKdvFxd5rsNkb+48+M5j8g0GJO94sKWrUchSjCuEugMlJKTT36cppSF3vpzd31Ki3BtZjHLzkCkJNw3MFBBUCLMlQekCfQiT+mKgULLbGZ3oYGnoGDCK+mWLGx42lIH1rC6KYYSYzXaOb9dZUDdcUo+3O7s1cgWYyfl/NtClbB6WXHPot9irSj6WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(8676002)(8936002)(2906002)(82960400001)(38100700002)(5660300002)(66946007)(316002)(66476007)(66556008)(31686004)(83380400001)(2616005)(41300700001)(36756003)(478600001)(53546011)(6512007)(26005)(186003)(6666004)(6506007)(6486002)(44832011)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpXZnNkMFo4WEZnZlFTNDRzRldqSlFKRWoxVllLSnFTaUJSdU51dmhDd0Q3?=
 =?utf-8?B?TTkrNVh6d2FUZnducTBXdXdSb251eHhEWmdjWEExZ0Q2NFVjc0NQVFlzRTgz?=
 =?utf-8?B?VE1Qd2hlYWlWZUpQV3p6YjlVakF0ZlJZNnQvdjVlYkIxRCtmaGRjekU0c1hS?=
 =?utf-8?B?eFliWEF2OXVFbnJtRkR0Ny9nOG1jRnVDcGJSOWxvRmJPOFNoVURpeGQ0SjVC?=
 =?utf-8?B?a2FBWE5VZDN5dTN6ZEZmMVlxeEVGRXVVKzFOdjhvMmtBMUl0emMyK05EcWtR?=
 =?utf-8?B?eFpVejg0blRKSE9EZXR3ZU5TU1Zqb1hDZ3JDOTBTVngzK0F5Y3R1Q3JDZmd5?=
 =?utf-8?B?WFBwQk9kRUpCM0VqSzBJeHNFVklIa2VVdTJIaFN0NGwyTk1LQVRDUlhkM0d4?=
 =?utf-8?B?blB5ZzVPT0hQYTM4eWwyaU9aeU9nK1dYNS9pWndqeHROaHhCYmxSdGVwUnor?=
 =?utf-8?B?MGVINm12ZXR5c2RwZTFVMHpFSFJid1ZKaFZoSjhyUUJybFBMK2JtZkNFZDZX?=
 =?utf-8?B?RVltRTRJMzh5ZExLSzhLNi9Ud1NFVDBUZnJDRXFjUWdvSXArVC93R29teVlY?=
 =?utf-8?B?QkRueU90UDJWQXd5ZEdTRjZBaEJHY0lyTUZqNTJVSVI0MTlhZXpQZmlNMGZS?=
 =?utf-8?B?VHRuWm0yN0pTRGZiNnJTMk9ScHlJSWh3M2phWWN5bmQ4MElzMXhvSUwyUXI5?=
 =?utf-8?B?OTArTElPM3RiRWphOVhob0ZZL0dRcWZzeXVjNUpBdUZEa3dWVG5sdzZRdEI0?=
 =?utf-8?B?WE1DYUZ1Y1d5cDgwRHc1MEwwMHR3RGZuQ0FqYjB3WjVub0JaeEN4MFdCTHBW?=
 =?utf-8?B?TGxQdWtYTEdMeWc5T2dnL3JmMFJkK041N1hrbU9maXoxQ1VQeWJ2OTltRWZz?=
 =?utf-8?B?Nm43ZzJGcEI0dDIzVllOcG82NHpSazFxK1pnbWxPQjZTR0tXY3VmZU1WVktY?=
 =?utf-8?B?eTlSV0hDS21iOGNEU2d1MGJVMm9xMEpubExSb3ZrV2x0QUFHaVNJNjZrR3I0?=
 =?utf-8?B?MVlKVEhZMUwrS0s5UWROc1Z4WUN4VFpCYnpTR0J5cTFiQWZHaUl4SjRQd0lY?=
 =?utf-8?B?aWpsVEwrUnFEY1pJeDVtM0lORGl2YytYUTAxWWxNSmNwcTFETWpzNnordFRq?=
 =?utf-8?B?MWcyRHRpaVhWaUEwYVBxZWpESENaRDhSRGE3TlloS0ZSUU9sQWczdXdrQlJu?=
 =?utf-8?B?UXF3WkVURzBybTJEWXltNTVpdWtiRTJ4QS9najkrVlVtYWpXeVdVWXF4RzRY?=
 =?utf-8?B?T0pQKzN2M1hXUXFwMmg4OXlsYjBXOFZxaWduZWdyd25Wd20vbDZvTUdOTzB1?=
 =?utf-8?B?MHBGWjZyeWR4NzVtNW9PbnR0WWpUY01WelA0RXlSVmRGOEQ0Z25yZjFNZW40?=
 =?utf-8?B?cWQxWUNHc3BLbjBaaTNyNTZweWVtdDNHK0RNaW4za3JTYVY0cnNNM1BQckcr?=
 =?utf-8?B?bk9zU2ZodjdxZUczUlVUOCtIejFnUDVpR1l6Wk85eWVZNTJVbEMvdmR2aXps?=
 =?utf-8?B?K1pWaW9NaDZSNllLRy91OEdkemFxTXVLN25yVXNwNm9WbWNQUTNCZGZBU05I?=
 =?utf-8?B?NjdIZ0wzbTlZTlFIRUt6QXljYy93TENqWXhZRUtYVlhXL0U5cVlSTGl0aXJV?=
 =?utf-8?B?TmtZbEdMVHB3elBSbkVEdjhCdTdnclorVlZoK1N0aWJmb3VrS1BFYjRtbHpK?=
 =?utf-8?B?Zkl3a0U3bWxOQkVxUmphZXFtcVplNW0xZTE5Mndxa0lHT1pDZlhXT2hMUmZK?=
 =?utf-8?B?S0w5WjcrOWdnU0VrU2hCdVJYK2k5a1ZMb3h0UHN6MGJIUkNVUlNkRGpuNTF6?=
 =?utf-8?B?ZGFGZ0c5THhIYXVEbHcvOW9jYXQweDl2SFVGNU0xVHdzTTZjVFpaY2RabWF0?=
 =?utf-8?B?TjVUckNvY1NrdElRRlNhdURNd3pXWmNVWFlTKzd2UXRmWittenBUcEg2VjVu?=
 =?utf-8?B?S1RuU2VvL3RmMnRicXc3NVhvYXBQSDdKZTZaWlR0eGNEclgzNzZxUWJqYzNv?=
 =?utf-8?B?andRdmV3ZGtub3pOQUFWUFlQSzJ5NXpIb0ZuUXpwYWJNdm9PWnYzRzlTclBF?=
 =?utf-8?B?V0FPbituYmhhNkxFWGxmSHdGb0Y3dE1RcWRRVEZvNlJEenRjNWkremtOZmk1?=
 =?utf-8?B?NFFGYWx2WUs4OUt6NGFaK2U3cUJWYnA2Q0JsUkpVNVU5a2VLTHRzZXNsTmNT?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd52036-0986-4868-98eb-08db6de8ad4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:37:11.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0agL8ZhqxKGah1DpJ/5CNDfEA6r2/Tt7CZNzNYohNNtXS9X364QhyXstsZB6ZsU/wFtqAob2ZiNqRJ93uqoRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:30, Dan Williams wrote:
> Per CXL 3.0 9.14 "Back-Invalidation Configuration", in order to enable
> an HDM-DB range (CXL.mem region with device initiated back-invalidation
> support), all ports in the path between the endpoint and the host bridge
> must be in 256-bit flit-mode.
> 
> Even for typical Type-3 class devices it is useful to enumerate link
> capabilities through the topology for debug purposes.
> 
> See CXL 3.0 Table-64 "256B Flit Mode vs. 68B Flit Mode Operation", for
> how to determine 64B vs 256B Flit mode operation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/pci.c  |  113 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/core/port.c |    6 ++
>   drivers/cxl/cxl.h       |    7 +++
>   drivers/cxl/cxlpci.h    |   24 +++++++++-
>   drivers/cxl/port.c      |    5 ++
>   5 files changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 67f4ab6daa34..7440f84be6c8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -519,6 +519,119 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>   
> +static struct pci_dev *cxl_port_to_pci(struct cxl_port *port)
> +{
> +	struct device *dev;
> +
> +	if (is_cxl_endpoint(port))
> +		dev = port->uport->parent;
> +	else
> +		dev = port->uport;
> +
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	return to_pci_dev(dev);
> +}
> +
> +int cxl_probe_link(struct cxl_port *port)
> +{
> +	u16 cap, en, lnksta, lnksta2, parent_features;
> +	struct pci_dev *pdev = cxl_port_to_pci(port);
> +	struct cxl_port *parent_port;
> +	unsigned long features;
> +	struct device *dev;
> +	int rc, dvsec;
> +	u32 hdr;
> +
> +	if (!pdev) {
> +		/*
> +		 * Assume host bridges support all features, the root
> +		 * port will dictate the actual enabled set to endpoints.
> +		 */
> +		return 0;
> +	}
> +
> +	dev = &pdev->dev;
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DVSEC_FLEXBUS_PORT);
> +	if (!dvsec) {
> +		dev_err(dev, "Failed to enumerate port capabilities\n");
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Cache the link features for future determination of 256B Flit
> +	 * mode dependent operation support e.g. HDM-DB.
> +	 */
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_CAP_OFFSET,
> +				  &cap);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_STATUS_OFFSET,
> +				  &en);
> +	if (rc)
> +		return rc;
> +
> +	features = en & cap & CXL_DVSEC_FLEXBUS_ENABLE_MASK;
> +	if ((features & CXL_DVSEC_FLEXBUS_CXL_MASK) == 0)
> +		goto no_cxl;
> +
> +	/* Determine flit mode from link speed and CXL active */
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	if (rc)
> +		return rc;
> +
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	if (rc)
> +		return rc;
> +
> +	/* CXL 3.0 Table-64 256B Flit Mode vs. 68B Flit Mode Operation */
> +	switch (FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)) {
> +	case PCI_EXP_LNKSTA_CLS_2_5GB:
> +	case PCI_EXP_LNKSTA_CLS_5_0GB:
> +		break;
> +	case PCI_EXP_LNKSTA_CLS_8_0GB:
> +	case PCI_EXP_LNKSTA_CLS_16_0GB:
> +	case PCI_EXP_LNKSTA_CLS_32_0GB:
> +		if ((lnksta2 & PCI_EXP_LNKSTA2_FLIT) == 0) {
> +			features |= CXL_PORT_FEATURE_FLIT68;
> +			break;
> +		}
> +		fallthrough;
> +	case PCI_EXP_LNKSTA_CLS_64_0GB:
> +	default:
> +		features |= CXL_PORT_FEATURE_FLIT256;
> +		break;
> +	}
> +
> +no_cxl:
> +	parent_port = to_cxl_port(port->dev.parent);
> +	parent_features = parent_port->features;
> +
> +	/* Enforce port features are plumbed through to the host bridge */
> +	features &= parent_features;
> +
> +	dev_dbg(dev, "features:%s%s%s%s%s%s%s%s%s\n",
> +		features & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
> +		features & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
> +		features & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
> +		features & CXL_DVSEC_FLEXBUS_VH_ENABLED ? " vh" : "",
> +		features & CXL_DVSEC_FLEXBUS_MLD_ENABLED ? " mld" : "",
> +		features & CXL_DVSEC_FLEXBUS_LATOPT_ENABLED ? " latopt" : "",
> +		features & CXL_DVSEC_FLEXBUS_PBR_ENABLED ? " pbr" : "",
> +		features & CXL_PORT_FEATURE_FLIT68 ? " flit68" : "",
> +		features & CXL_PORT_FEATURE_FLIT256 ? " flit256" : "");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
> +
>   #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
>   #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
>   #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6d7811b26b5a..bf8f25063914 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -665,6 +665,12 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   	} else
>   		dev->parent = uport;
>   
> +	/*
> +	 * Assume all CXL link capabilities for root-device-to-host-bridge link,
> +	 * cxl_probe_link() will fix this up later in cxl_probe_link() for all
> +	 * other ports.
> +	 */
> +	port->features = CXL_DVSEC_FLEXBUS_ENABLE_MASK;
>   	port->component_reg_phys = component_reg_phys;
>   	ida_init(&port->decoder_ida);
>   	port->hdm_end = -1;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f309b1387858..74548f8f5f4c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -536,6 +536,10 @@ struct cxl_dax_region {
>   	struct range hpa_range;
>   };
>   
> +/* These start after CXL_DVSEC_FLEXBUS_*_ENABLED bits in port->features */
> +#define CXL_PORT_FEATURE_FLIT68 BIT(16)
> +#define CXL_PORT_FEATURE_FLIT256 BIT(17)
> +
>   /**
>    * struct cxl_port - logical collection of upstream port devices and
>    *		     downstream port devices to construct a CXL memory
> @@ -557,6 +561,8 @@ struct cxl_dax_region {
>    * @depth: How deep this port is relative to the root. depth 0 is the root.
>    * @cdat: Cached CDAT data
>    * @cdat_available: Should a CDAT attribute be available in sysfs
> + * @features: active link features (see CXL_DVSEC_FLEXBUS_*_ENABLED +
> + *  CXL_PORT_FEATURE_*)
>    */
>   struct cxl_port {
>   	struct device dev;
> @@ -579,6 +585,7 @@ struct cxl_port {
>   		size_t length;
>   	} cdat;
>   	bool cdat_available;
> +	unsigned long features;
>   };
>   
>   static inline struct cxl_dport *
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 7c02e55b8042..0da6618e0df7 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -45,8 +45,27 @@
>   /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>   #define CXL_DVSEC_DEVICE_GPF					5
>   
> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +/* CXL 3.0 8.2.1.3: PCIe DVSEC for Flex Bus Port */
> +#define CXL_DVSEC_FLEXBUS_PORT					7
> +#define   CXL_DVSEC_FLEXBUS_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_FLEXBUS_CACHE_CAPABLE	BIT(0)
> +#define     CXL_DVSEC_FLEXBUS_IO_CAPABLE	BIT(1)
> +#define     CXL_DVSEC_FLEXBUS_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_FLEXBUS_VH_CAPABLE	BIT(5)
> +#define     CXL_DVSEC_FLEXBUS_MLD_CAPABLE	BIT(6)
> +#define     CXL_DVSEC_FLEXBUS_LATOPT_CAPABLE	BIT(13)
> +#define     CXL_DVSEC_FLEXBUS_PBR_CAPABLE	BIT(14)
> +#define   CXL_DVSEC_FLEXBUS_STATUS_OFFSET	0xE
> +#define     CXL_DVSEC_FLEXBUS_CACHE_ENABLED	BIT(0)
> +#define     CXL_DVSEC_FLEXBUS_IO_ENABLED	BIT(1)
> +#define     CXL_DVSEC_FLEXBUS_MEM_ENABLED	BIT(2)
> +#define     CXL_DVSEC_FLEXBUS_VH_ENABLED	BIT(5)
> +#define     CXL_DVSEC_FLEXBUS_MLD_ENABLED	BIT(6)
> +#define     CXL_DVSEC_FLEXBUS_LATOPT_ENABLED	BIT(13)
> +#define     CXL_DVSEC_FLEXBUS_PBR_ENABLED	BIT(14)
> +#define     CXL_DVSEC_FLEXBUS_ENABLE_MASK \
> +	(GENMASK(2, 0) | GENMASK(6, 5) | GENMASK(14, 13))
> +#define CXL_DVSEC_FLEXBUS_CXL_MASK GENMASK(2, 0)
>   
>   /* CXL 2.0 8.1.9: Register Locator DVSEC */
>   #define CXL_DVSEC_REG_LOCATOR					8
> @@ -88,6 +107,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>   struct cxl_dev_state;
>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   			struct cxl_endpoint_dvsec_info *info);
> +int cxl_probe_link(struct cxl_port *port);
>   void read_cdat_data(struct cxl_port *port);
>   void cxl_cor_error_detected(struct pci_dev *pdev);
>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c23b6164e1c0..5ffe3c7d2f5e 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -140,6 +140,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>   static int cxl_port_probe(struct device *dev)
>   {
>   	struct cxl_port *port = to_cxl_port(dev);
> +	int rc;
> +
> +	rc = cxl_probe_link(port);
> +	if (rc)
> +		return rc;
>   
>   	if (is_cxl_endpoint(port))
>   		return cxl_endpoint_port_probe(port);
> 
