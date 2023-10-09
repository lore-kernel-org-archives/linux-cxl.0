Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB72F39
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwsbhW0o"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0EA3
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 20:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696822974; x=1728358974;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=DirgqOIwXxkHvtrR/NmOkpomnEAKSKqLUiybcUduu/o=;
  b=bwsbhW0oXIQ+GdFRUos5F6GY7S1QTtwLF3dIi7f1W0ZjugYEYLrQRXPM
   ynzGYioTrccIgR5dPESRo1qHDaWknVwUesddXE/wGh8X/bvuAHy4W8XhE
   4A0AiIS9kjLMquwFMOTH0XOtYo46RAn2WnKdalZU0F+Z5Hw8FUh092S6I
   F1HlzgKnMIljl5JGP53Lrhiz0OLVvtW7x3p1KzjJJcDELiP2WAtB4crRM
   tOoGphXDiY/o+1r4G46bg84gKJX9quxsuE6JNpPbcpX85iRXMKGQjSo1z
   KoTIH1Vx4dWU3Z4dFCG7hVx7mJLvWqcUAznivSccdIxlMrVa1C2O1ZNUe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382938513"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="382938513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 20:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="823186730"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="823186730"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 20:42:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:42:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:42:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 20:42:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 20:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LszThe9HL/5nX7ntyHiCxm1/+H0WNxf0pcdj7mctxgZ9EyMgWVt94bRMFIN9UVrxkm7iPhGFmxRMSD1E6iebwypjVXNpXVSZRMAOGzrHnACgJ74u2gCI33eFjgBW1dgA7adGs8xOMzQOm1eoBsffHP0sOKXhyex+KCWMcCG84wf8cXIMzDTrY4rMe1LnUtyL6qCcSsig+sWX97ft78utA96O+3qvb4x1vrL/IIfFn3xDzaYe8/VMn3ymZbR5VKd6aqdbGrEp8lZlJYOmGxn0OfyAfgWDBMmL4GK4hVachwCqFDo2CD2aouS4Q1vKc5/GyM+X/eqF6V6htUsXllmQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm6IN7CjasQsjMN4UYDySeTgEWgRJPA/EreTl8qx9DY=;
 b=QMgAyvMroDHKM/T6BxoXQNG16+DyabTuESa1KDqDq2zdS/zJQ3c0zY1qlqNujwIJ9Fd5N9LjfH0QLYUf3zstLYwaSahYVh1PdUZaKqBzGA2/sbAXh2bDwjAyXrxiM2TJpWNE9pmDBioumfJVvU7l8DFcJG5hrhFfeaTPOSOy5JeTvM7uZzHD3rCEc9LiB5FT9H1f3MB0aCUz5zxF8hx9wD0S/Qnd5JplNb0V45mRRKWP3lSRTAmC5ddjEyYV4psL5MXuY86xjZG0EbEsk7mzJjSTV/jVsLFkPzYNdbosHeBmEN6FM75Ec+xMWjLagLx83CfIxGVrFiHM/lrAmaaK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Mon, 9 Oct
 2023 03:42:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 03:42:51 +0000
Date: Sun, 8 Oct 2023 20:42:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] cxl/pci: Remove inconsistent usage of
 dev_err_probe()
Message-ID: <652376b08566c_1d9884294a5@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: a47b0439-68a5-433f-8cf8-08dbc879d017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88GGtlnNTf4H1nu7CX29MGkXhNBLfx03648sNCoXfIj2hi7DDImGmsuwbX0OYyh5t2gYVmlU+hHZe0SMjtavoktb/hIM2m3ThbuJdnsIgifuAPUNOX8jti0HwEpUpfQMCVPr9gUPLS94xOT9ckvEciSV48OVsqnp7iBfEA4kVzPdgPfJji4HespapC9FrfbjJTTdQf1Y1RIkZG7KQBBYIJ0jHVPfdIoPxpXQgj95c/7J//NdMm+jqk4t1iWoRjREG+7p9KIp2e59bCczwV38TNSo01ITixLCpbJkQ9UVdK1eJutrlSWqjHjc0GEfvck21GfuqDFkh0wepZxzLX42bYYZZUUn8pcpmworh7V89WOhj6TKgflUCeYwwiYVo6YJRZ31zCQ00uPeeB4szu4ASdu3JUXzh2wsXzSLMQoHeEVEqjfSkn6ENoY2ciid4PUlNRxddPpjxbjO4xvSZIWd1W8vbbB3VJ58TMOhgzqVJ405CVGdKcC3TK1DFGZX/oZgmYp6V335C2hSg0ZURIQBXXacmgo99DDa5p10GlHUU3o6vcDFCFCd5d/i2xzEja5J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(9686003)(8676002)(478600001)(6506007)(8936002)(2906002)(83380400001)(6486002)(6666004)(4744005)(66476007)(316002)(66946007)(66556008)(5660300002)(44832011)(41300700001)(26005)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOknaxn2EQlTsqGArFJPtM0g67wVeqR0qZuL3qistDgSh2Ndv22pEyYnbzDP?=
 =?us-ascii?Q?N0CmzS+dETiCVZpqkSY+SnoNABQ55RTNuHFnzjZOkMecKlIEt4O1Q+PDZHQq?=
 =?us-ascii?Q?LckghW4OjRUU0fXJ7wLr4ZXgl4v/jcAU0TA9+yvG82b9QPAwRZGDmjrVXyot?=
 =?us-ascii?Q?Xp/8JXpaxb7ihFLNj8+iZXjUZ9PQVQmVZAdhUWcLm/0MQYxudjs75rN7kS0I?=
 =?us-ascii?Q?99Ovg9pIKH42nlHbQsmf1ePntQw8+jIUXmK8cYDbBkU7mMQgs3qXtfOCCKe1?=
 =?us-ascii?Q?PH+hUUbWRiXUnvvJNnhSFzdHt6RVPAUCQn11CBhvTg32MxAZvETf1NpxGILq?=
 =?us-ascii?Q?uOuTPFNDxkJMeriRbJdLuY1EyR/zbljHDLlCBLESMFUSivfh2FK8KzrzcPUo?=
 =?us-ascii?Q?nY/QSyKbPxxV9zhf3vTMEgYaZkGm/tBL1STxDYAMxssbyzBnIG9Fu8WcSzFe?=
 =?us-ascii?Q?c7LAWvYNS99eewJET3Yk/XrLxd4rtbgxcmgycocQg8mlMc16x7bLxITpbxg8?=
 =?us-ascii?Q?9E3OcNZp5DGWqj0D5OYanA1pLSSOCn3ZGYBPwJSDOC5/GZ1n9wXkEaVA8Klz?=
 =?us-ascii?Q?xIcj8G+KwBfG3q4EIYOxoDZ7DaTVLUgO3lEiZbAY39a8aJg76aenav2TWNrb?=
 =?us-ascii?Q?rwMpt+jKVFv/S+ZH4uU85v8gNYj2AIft9NpUr6/PykIVF5j2e4uBMtGE4gpN?=
 =?us-ascii?Q?d1MZLA/7difP+LEU/PjUPeMFK/aRg3lg3ubReY51zs6aVRvNFNrf0sb4+sip?=
 =?us-ascii?Q?sacACxnlDLntYhxXVZnUYb95QdanROBFgbuIFGsnINPyN3qZND8GM9isHett?=
 =?us-ascii?Q?/1okiJMNoaCfrZ/4lCMXTyf+7XIFwjX5eFyKLef67ZQwNSXPabNCbnuQYpTH?=
 =?us-ascii?Q?JJzYQd1gyVxaySKBQQOYVdgjXmAZMVnm8uwD4iA2PWCEwfipXatUHkgGOdWk?=
 =?us-ascii?Q?z5GWtNc9ibCvu1AXxmxy1QOXppuxuN/JOcMzbSgSB0HOiytUy/tWGk6+8ixq?=
 =?us-ascii?Q?4NB5JsyJpFFrQ5O1eCmSwOl2g476fXHtKyrtS5r5jMjXu21pxmzpKno0ynlF?=
 =?us-ascii?Q?Zfvdzg6dMJyTc3WEtQ8NCqlGdQXDIO4CGnjMpt9UFPHEgSNb/56EMlZtXmLo?=
 =?us-ascii?Q?9NL7Ys9eZPiM3IcbBD4OKPCMAF8isAZVMZ3lvkV40k3utgrlKocLRGjIol52?=
 =?us-ascii?Q?Y5g+QnQjxcr37Xd3+M+JCZG277bp/hpS3tkUKwJg4dYViIlIo/UXTyBWAT9o?=
 =?us-ascii?Q?E//LsyP5Al6ExuRoKbOhbUuad7tUp95wa6tve4b6cPhSXbi9aQKERwC8PKtl?=
 =?us-ascii?Q?7VXq5Eog3HgOJjBOR1ahigkkNfzfbhmzmaO0z0F+6IGy6w2VlpCDGzXl3HCR?=
 =?us-ascii?Q?rvV0wGELbW06DwJAs9Scvk077hBhrZ7AzG8B5EY9Hp46sVYQZvyJ+OtiBJqz?=
 =?us-ascii?Q?Xr9SA/HQeY6LdVw1n+C1gU/haLDozmaSQfLEIZssmrGY1TPmJUAyQAI3NC1W?=
 =?us-ascii?Q?9ddjfmV8W8OL4yBz+Tuibd4sSh7qhsLhixHnjU2iexPV5gCXHQrZOLD2jXp1?=
 =?us-ascii?Q?A9/f2aGoHPKC9ggj338W9bHYztMnFYGa+KSThUvb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a47b0439-68a5-433f-8cf8-08dbc879d017
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 03:42:51.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik7VZjykDRm6FbYppkNQAOt0v+LLFMNlm3WKoCMsgv186wC899Bcud7j98GfJyUDD9sh9S1MqqHTNsiFzUEB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> If dev_err_probe() is to be used it should at least be used consistently
> within the same function. It is also worth questioning whether
> every potential -ENOMEM needs an explicit error message.
> 
> Remove the cxl_setup_fw_upload() error prints for what are rare /
> hardware-independent failures.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Seems ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
