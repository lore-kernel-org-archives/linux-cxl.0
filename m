Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510853EA82
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iO969JRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702659339; x=1734195339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BKZOoDQQCzAG+EY+qIh0m5sejR81Vo4auvlyIbEbn30=;
  b=iO969JRYm02zXWCIbevwrmoM+hqxjjEDCg5SUGN4yqX08YlK3Pf16etk
   ygtuaQt0U6FSKyWjjQdzI3mzWIygHFrBeZAl9pNIxIw6ErbylmGoZAnPh
   N6VXpMieaYApva00irO7k6ZDZgOdRnAahRNkeriIQFG+i3VQtgTWiTPNU
   SvL0IjCUIKNCi13xDvEy6iPcYFd7hmBSYavCvoStx24sWJ0VETMb/dzaA
   WJ1AsAdd6TIEItySfaIzYEgwToYNbMZ8nxyur0+zOTyt+FFsduYppOzJZ
   wlzZIkcmz/Z1/Q47mgFwsGaD54/jb9Sl9fuUkXRyvYW3a4BXcjdZ8I2yj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8721821"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8721821"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865459724"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="865459724"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 08:52:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:52:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:52:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 08:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9RCN6lDyBnuBwcHlodgkn6kfNyhpKHdXhL55qIngJMQ25ubXt3qiUjit1ufJGruISc0q5ZD1XPYyq3xQYhtQa8rfS7Faq2IPaFfSRf48pYXZ6GyQqIjHwlg/yjbmTmdgHCFXCSR+kv3KMfbwkKfSs5PIjA/Vambiw+9gwtkdVCwxH149Lr4uAI/K1Rt0tAo0n/kSVjb+nqmZmAxVDk3v+4l+CaJLgrfLOsOvUOEvUNkuRifc/gmJYhrWwHirwRwrM6ZG7/JgW2trsLb7U91FbYqfaw34m749A5xJ1MOA7icE3s5btJqp6kTllRbsSz2Q/lMoTXfl8pECnOZF2ITUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vagRmPYnKGpgUljToYfvIiRipoct9wQSNvoipGDlBI4=;
 b=OOV0yTJGR/bixyi0ZCZ5+R9oZvs6frruvS9eoWSr6Bl0eny3yFOyxSgyDm36zwiMX6VStluLsDp9qHmeVsrP1RYCDtOHVJ1NNuTJt1VqZXF/WZrLWx4z94EMmy5GURlffHWZQR5nPyvsiShhufAgqRcSfLbgl8Qj85ML4qEH/EnSfi1Pnh1Zillk/GLvC7p4KW0olTNpRSvCFmvEcnS/FVOH2uUyX+doARPSJSVGHfY2xTeTavLBxXi0gy47IddW8dZC22+GVLU96XbrQjF2p83wKVlDS60K3sHMnxynbS4aCqGVDWFRudWGodhQUnwiLM5Q8hRuIpPQKsM8sqi1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 16:52:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 16:52:38 +0000
Date: Fri, 15 Dec 2023 08:52:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <657c8454a31f1_2947c22949f@iweiny-mobl.notmuch>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: dc11abea-c3f6-4f44-741f-08dbfd8e3ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2G4iIbZJhZeTvIUO3vE/YJKtAcygIEm5czu7/mMZKK306OLvlMkBs3JJoAQ+VPsKoxXqCWbJfXyaJ46FnmZC+JtmUjIyVroQY4Z1LmEY2zsSmo2+mB8RB6LEtzPVKMjmKKVgSGzbRzCKjqgt/V1E1txHSjE8pflKlOJOFZPXar+QjMwSU1oZsrGg+d00nH2VrCzYowiaA5dXm1JGiitXhg0TXk1il2dIlxixulJ/Q+aKZ6CFJkO5TWb1vnIazzYdLFgNCUwNAAWby6Hg/G0dkwal6KH9v/5LkwvzEOzCgHaEOVvL2szDvfRlKIdZXgZlxIQEykxqX9eiuQ2VVDHJ81SxLr32EveyoP+k/ZWtfFpv8RHBTgqTJ6rymVf13egi4qeeTeQ2nEX1kCOQXnYs373Uk8rQLYQGEFYOsI5AO0sgnCsdNb6V1TF4A4y9xFeFs9pJjE+qFc2GOWN5bTA/rKO5oAUr6fZzsUdZ8ewBiP1ihNJixDK0fFQwDckgPKSW/63ZcyFvej3qdM3Nn4/g+eCGDwiNDnA7GsCKdC9eg/jjif9J+cC+gsS4gouF8Jks
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(66946007)(66556008)(66476007)(54906003)(107886003)(478600001)(6486002)(38100700002)(44832011)(8936002)(8676002)(4326008)(86362001)(6506007)(82960400001)(41300700001)(6512007)(9686003)(83380400001)(316002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5KU+WjAb7BwJAWNiiISX+gfIL1+MTAAmSSqDRqdWtxs0tMclUm5WPaxYWML8?=
 =?us-ascii?Q?I4WOoTnHZ+pJuv2va7Jc1VJ/eh6ug5UstuGOINltv+hLTsXJzXYgwO+kA2BM?=
 =?us-ascii?Q?wS9hBXN7MxhVKPQ20pE9GLYcp0vPbKNboCgl0y2Ax6ubyYcdo7UfwrajrzXn?=
 =?us-ascii?Q?2FdbZzDwaRrP3cDFo8IVsfnCMU4m/TkHTrJ/uWxY5P0NoF/ZjipUUAo2J7Tm?=
 =?us-ascii?Q?OWbiNXD9uiMDBCXWRysi+a8tYmeV8Ug+a556/Bgjp7PJb8zeXS2voZAu1Ekm?=
 =?us-ascii?Q?Pbl55ASCeDUEeqaMGCX3Dcl0ye9Tsd+PSey+VEvG80ZTHV0RBpiHOmSJkGth?=
 =?us-ascii?Q?NggZVBAZIMfJLcUPN3QuFl7dOdO0FHiSMluE08lj8v9XEU8NI2FHDTBAwbTP?=
 =?us-ascii?Q?Rw8Z/nyKKx2G+PSPr4hkEwsEQkID/eIPq0Eg1g+qXHB1E0KlQm+8jBIvAAHm?=
 =?us-ascii?Q?eoEcoPqYvH7vwqWSCDvjGOdhnLhLyQwi0LT6kN5IBydV6Z02weGpjYAt7wEk?=
 =?us-ascii?Q?ta9hDknOKBOmJNFfMR8lCI8WyTvhzK/6R8PcyOMUw4I6buSGkgX/WI3pwx/G?=
 =?us-ascii?Q?OGq1QIUKlZuAKS2zqQA4zSVOYfjPh8NDTrG0sAuzv7HWml+TXau3gnJPbaCS?=
 =?us-ascii?Q?1/9CCiP7BNLGpoXWe65BE0Cd2XozQxqS9/TiauodFUUvIvq+jQYp1xMCcNOa?=
 =?us-ascii?Q?c7UiAi5DKTGCKjIi+EQxO9O6K6XXNRkkad6VXsU/AEm+opugggTibuaDTnGh?=
 =?us-ascii?Q?dNhHZI0r4N0BdhXVK5LFY0h2JTSPS+aC1hrCrg3RKWbLv0ztdULt/dBZKUFE?=
 =?us-ascii?Q?39c7PeK4ozIU7CelbTuBRpeqnJfPVJ/+YkttHYeQkhBlD56s7MDSaEzBk+68?=
 =?us-ascii?Q?1TcggQhc8WxKedAvdLunz7s1K+0T16o+yu/rJb6X1HMCboHpUSij+8z+JBRA?=
 =?us-ascii?Q?vVVKkx2KfbbGRWS55K0uR37w4w4ZkTa97oFNiwKBciDjThLIxTpIF4alLXZ9?=
 =?us-ascii?Q?tv2YELzwqVIyLBtKR+jfHEGryZkl6zpehp1dJOs4/6Yvb65Kpcc1YbH4knag?=
 =?us-ascii?Q?IVeJlZW+hqs4wvQfHWcHZdiSTpg9jh8wQSpUhQs1w6YMDLM+elwQ74G3qZWJ?=
 =?us-ascii?Q?2u6+6sdKeE3SzeVBgTGqowK/WnWeqwKGloT8cWY5YNYIf52pagVo9tZlXBOP?=
 =?us-ascii?Q?p4hYUnS0q9mSx/IOgotnVFiYpxl0YZTCprKpY6NlZY5TVy6GE2Yc1PXnbTGA?=
 =?us-ascii?Q?fkbxE93CkUGah90lFroXABVMfYP2IF3tbBDsyBiwtI5kICvYROg9d5FJBDkM?=
 =?us-ascii?Q?9s9j2Pnl0wyDQBiy29SGpzo1NUthYANkSFvaJblki6FiC06UN6/f06ENTQ0J?=
 =?us-ascii?Q?hyd9mOkY1/NivQbDKmpqMHVKuivgXd56jjkgFEOzhHd37jCqFtEvBJg3I5zM?=
 =?us-ascii?Q?dWRuiT/jELpUmeQAGeJocPQSkzaS6lnNHT/qBKKMlvEsKt1CBgOFpLbsaH2p?=
 =?us-ascii?Q?rCFfJJJCQoWJXF9d4kxzsN2UrKfn5LJNZAjCAQHGqmSr8/+KH253xfdUlo4I?=
 =?us-ascii?Q?lZXmtFlPQqhuCR37QS1i0KrZWydPrn1KFn4UwTX4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc11abea-c3f6-4f44-741f-08dbfd8e3ee8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:52:38.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi+MKlLhr0aVtLb1oQC3cCn6jB6R+0tDJqQqHDOpQrjUWWWABcCde/U92oSrf6XxQ8RTKC5Wm/KQtEAOQRNE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Given there was already one bug here around passing the wrong value in
> the cleanup path, remove the goto with the use of the __free() helper.
> Note that since the cleanup helper only passes a single pointer as an
> argument the auto @tbl variable needs to also include the @dev argument
> to devm_kfree().
> 
> The open coded math to shift the port->cdat.table to the relevant part
> of the response buffer is saved to a follow-on patch to cleanup.
> 
> The "devm_buf" scheme can maybe move to include/linux/device.h one day,
> but the expectation of using devm_kfree() in an error path for the same
> function that performed the allocation is a rare pattern. Many
> devm_kfree() usages are at object mid-life or end-of-life time, not init
> paths.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 37e1652afbc7..dd938a60a2de 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>  	return sum;
>  }
>  
> +struct devm_buf {
> +	struct device *dev;
> +	void *p;
> +};
> +DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))

I wonder if this deserves more wide spread use?

[snip]

> @@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> -	if (!cdat_buf)
> +	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> +	if (!rsp.p)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
>  	if (rc)
> -		goto err;
> +		return;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> -		goto err;
> +	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
> +		return;
>  
> -	port->cdat.table = cdat_table;
> +	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);

It is unfortunate that we can't get rid of the mystery __le32 offset
here...  I'm not seeing a quick way, so...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
