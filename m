Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F412C534;
	Wed, 24 Jun 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308594; cv=fail; b=CuWFulsXrqhwBhPE1+SNlDhfcEEwL3wEDutwLUZ2OawVC+fFwrQzi1LB336VDdWbMQ2b5EbgBsC3hXcTlNrTXsVwtnFoELd3qPCvancNSWd9cbW3FfXwpz1Po4QHUvL7gO6EZoywJCTqauGT7nY+m18g2ZjJRD4KMkQYYvPlFd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308594; c=relaxed/simple;
	bh=2rkcKNSJgqql163vC3Uc2U02R5IWd8np0vEi87XvuVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NivO0My8+2myPnL0pfh0bzEG10N1HsW0TCqUIBDzWmVeaX9AaBEQVUIHva6kFUEziPhMHnzYQqOYyCM67JhR2v64BjauNSLYoW2W+cjUAM7HrsxyA3rxe3PlFYo12iks3xmLZsM9AJYDSyQEKLkxDM7yH4+PVcAr6RQW89NlN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8kssR1H; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8kssR1H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1m6e2CSjqFi1jLR5eH/VssMqi+kaflTIw4AdQs5l2HpsCI6sA6b/IHNgHs45/0PTodJyLTh2fdF6/x/9iCCYmXxrFypGw3uR3EQYbgxLVr/kKEkobHsDM7hJBIktdAetV3ceAzwdfIws3Lu3XQtZQyAWz6L80M82bNaZYoNuDanGaBOzajgtckqStp3EThp4/ChsHQkI2iPu3gSztpUMwZVeKVyJg3RMGPb1R/fOlkn1l4Hu4CnT82NLET4Vlwl7LewLLTmul52+FOC5wqwtX1x8aqG2tTUeFRq719oWWwtvs+Tfcsy7VP2BTST8Tfj21ZNz2/fFZpCv8koqS88xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNvQioC8ubA3bgWw/KPg6lBZiF0DsgeBcXAyYTT/hxc=;
 b=gxIBRQZ6HoL8++R2+WwCYb2W0/9HXHoIRTk+MO5vw5e4ZrkFRxflEinDyKoQawMJWJjrabjjDhMtXu8b86iJmRr6jMD2wwK3Pg1epmMKKIr7cL7CBpkuudxnT4w0U4yE1kuEnc9rovpwcqNByCC+w/c4+fz3vFCHVUfTCX2iT3xS5doLVRmRWAq1LdcyzfhY7WrtYnl/LSSceMas6tScSzRaX6ud9ONhSTyUA3lmWCGzaOt1FpfiNE/QE6XDonkSgE20d6JSxb4H3KUUW9Ykqx4gYCzEZpMdnGmElSqvPo6t9AexAJv2LqoCY/UDXmu5860wllqJ293IdFrfvt2X7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNvQioC8ubA3bgWw/KPg6lBZiF0DsgeBcXAyYTT/hxc=;
 b=M8kssR1H8Sl4XUgGZUJZvUcWkZJwMqjgZtEJMzo6vfTD18ZoRJLlbeXbKycs40SWz8K41TjhHfONZW162ecPBqtdyreA7cMicBFFk3BkVKr6V+iwQN7NDBWfvzrzvYbWlHVosOg2crkxysO4G66lM6/GGdpzo1NGeB5JmAHeVrYs1s3tNVY4XWWdEbtLVPmhS7CMBjjRcWgrzclyxO9pQPsZNWtcQpa7qr5LDEFUZv57yMjnMe/XtLtlkH+9z9EE9aoKul6r6+5keVbPX25UIEDKGBM7zJGsoR4iNPhyQgrKuCsG4SqWHWMgX/u9WDrg6Du1lkX9BtVoprQ/6A3oOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Wed, 24 Jun 2026 13:43:06 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 13:43:03 +0000
Date: Wed, 24 Jun 2026 21:42:52 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: fix mailbox return code description typo
Message-ID: <ajverJTK87saqUNw@MWDK4CY14F>
References: <20260624122835.5656-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624122835.5656-1-alhouseenyousef@gmail.com>
X-ClientProxiedBy: KL1PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::14) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: e70c19ed-b36c-4f1f-56bc-08ded1f6815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	RIvvV1ud1SLTMbQ1mZcCqJ4NZ1m2HNOxCcUXXz1q+7HwGtNZNcSDncvmxHyPL3gyp1YMkV4hUCRsgKI4PH94ssw1BZSRywxe0ah5w4gtjagKYDI50YoJrffw4cal1EQxLGDkWVYNGUa0dUIna7F+FzxmOZfpXXfYks9Lk2WWOUcJH3aVwk7SUhBTFGA37gFYEK5znM/BODPoKs0H2Ja+WrGBXuXhdv3WpDzBwNUe3IEUaprFFO0F3zYOwNWj/2iBipYBlXpxIrjmUbXVPLA/Mg7StZWGeSumYAB+cc9cs0pLjXQ9WQD15awBhiD3M0WMKnBPgvR2aS/QG3yzvKmOUUGsdjmbesFk8TTE3LjPtJZoKm4L7NQpERufBYfSOwfd6C0Nsu34U/TajIbXcPF2YTQmJ/oT/6yepDd/PG5C9RVUMaFO9qhoetphlxdhx2rs+DkIyxrc4DsLM6Ofd4Th7cb2WEWofLGSiIoQwOxH6iHteSaSldMKj+b0mc19iFMOQSKcp+ibv84DQi31XLo/48Svn25TD/rKQjpAK1aN0ICaGgrmNNBvt3U4juRZGPllzcBBdTaxkYTj19vp3neXbTwdxxI9gAHU3C1EtbSPInnrqi5s92DvLgbftq2teC0uWMkRTITXHGALIWxMiO2xoNfv0H0DVaW/1IVzS5tIiNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QSiIzNhulmuZszHMDty9e1t8O/wEJb9MmNK3N+eqKK08dBmSQJYONvU+rAmI?=
 =?us-ascii?Q?2UyetUIiy8qIYHh2DVnIF1Bw27z+grYkq6WL4RfI9Ndziz+xNRde0apAFlHD?=
 =?us-ascii?Q?0PzpkRwgOYYGy4JVQMglJQbpav6qUbS4c1Rpvv1ZSUxDNuIljtXG0sE4vlcQ?=
 =?us-ascii?Q?D3SEG0Y18cRD5Cne58PkpEFlvc7HmPXhV0wqF+jw5VX0axn2y8Vlh0ECdOKP?=
 =?us-ascii?Q?Drwe8+eaCwHtITp29YSZGp73DhZfVSIGwZAD1oIrSBv2fX1ZuevG7apBvl+I?=
 =?us-ascii?Q?QFfMUPaHNwTu1YWxnfU5s6ACdZiEpKp/rUsPRDlneKmAQPxTeyjGWwgLTDFW?=
 =?us-ascii?Q?WMaRIwQK1cc9LJQffpgpPrMMQdjezwo99BTUt/jdKPF64fLPNKVEM0WKnek1?=
 =?us-ascii?Q?sfLFVKtYCjk/IyuqdQcb4uK/BFxksNgaj/PgLOg96uJAmy/iaZRu0JWfj0YD?=
 =?us-ascii?Q?YgJozavLnh067eoWrlMtkzHJHAZ0cR1YW9lcxm1GWs0fygmDpGwNuMQbXDQ+?=
 =?us-ascii?Q?+BtIJp71TqpVC/ppD2HNX7J/bP7BkgPPkfWjj0vX19q/OLXcY+JbUennjuQD?=
 =?us-ascii?Q?RGJCBICUEljaxBJ+7m2lV18nWZ8a+rszlxZf2IDWM59PpnHj2e44D7GXYMZ6?=
 =?us-ascii?Q?skHA+5aCc6at1F75JYJfMPuppSaV64GVkzbQCwnKrvxlgbzI3IzZAATOcJzi?=
 =?us-ascii?Q?rxiyiAgjuU3ua20NEfrImREcVZCndWQ92r9CCSqdcDRQMyzexnL3PxHY4SkL?=
 =?us-ascii?Q?uyQ6ru0e306fFawVAJN4myBMLJMyAGMPIs4BI9t92e1e3LrJ4rCqyhsRJ2Dt?=
 =?us-ascii?Q?0f/XCyyxi2ZZUwyFCRX8VG1t2S18bF0zyeyCMrPNA6Z0smRlyT9xPk2okJNN?=
 =?us-ascii?Q?FkOBFb2M9P1DPUVQ2Zdp4iaT5pTR9/IO6AwPDbaoPliSUFBK9vD2GQOtDIvh?=
 =?us-ascii?Q?8LWHu+ojSU1IViWxVH4BuXc7zoPqt0DeF1NDMprOJ3vQotucn37+qHahE1Nv?=
 =?us-ascii?Q?wMTNxQN+H26iQATllDZiPZbbgtJSk2TnEk5UaD91IWKOGRfUPhWumW7V19da?=
 =?us-ascii?Q?w5ilLIn1UXGjX79RRlcBcRXlNLpeMAdWyD7NsY6YuV5bd5vJP5htLMaCeKpH?=
 =?us-ascii?Q?5V56WY2IDs8pwVIGRx2rLiMhHV29uvURdsoqZxCNmsvKwQHxjgPLFY2pKezS?=
 =?us-ascii?Q?Vf5XxIv7xrYAhgZRwzbiYrKX+wAc17shqitsIHMSanbMGxLjKTFz7X4nVi01?=
 =?us-ascii?Q?/hJF/5qETMKKnUBIwBuB/ljKEgIM9Rbg/7m/XzBtBcbfqiDN1k7wg8SpkdZd?=
 =?us-ascii?Q?o46MIR+COc5aySsMLTJlErNw/K1ZH6XHBAlkzcuUhlIkD4mgeF7oI0I/eeP5?=
 =?us-ascii?Q?CCIA7UBqIOLlT4eSjw7y2OuOwjYlwRVcOBemk+x3PnFDj4qOV+e1W4yJ5P1C?=
 =?us-ascii?Q?siYanu1b0mFone03uBM/UjNVw+Aax3yiPPoxbzQPgD83gnEuNdnj13IS6q7e?=
 =?us-ascii?Q?r6wtbW6Po9XbT3pizxyhwatoA/+dkRMlznSkoLDEwgh6Wyd5oMvcBluR2dTi?=
 =?us-ascii?Q?HR/6iwNvDf+OePW6QVjoitisXohrw/IdS9vUMEcbNvhe1GGxEMSlkLmVqyOP?=
 =?us-ascii?Q?cWyMyvy7jNxejhFx3vf+TcKA+lKlF3jzuzw11znH0ue65PX+EbTD3UKwoKIA?=
 =?us-ascii?Q?TBzSuZM+fwefUUv1T6C00yMhU3tKIJVVtYuyGbkG6/W7CzXNdze+wRlkThyU?=
 =?us-ascii?Q?5W3gYF3T2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70c19ed-b36c-4f1f-56bc-08ded1f6815c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:43:01.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SJTKIu0Gc/6d3AylK8rIP7GJMI5AnqfebS+vGadA4qZhQOMXUvlx6RKTtupYeUeJhZuUhRYdQm1JcBQayDK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

On Wed, Jun 24, 2026 at 02:28:35PM +0800, Yousef Alhouseen wrote:
> Fix a typo in the CXL mailbox command return code description for the
> interrupted-command case.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c5..503ae2864 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -183,7 +183,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>  	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>  	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
> -	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
> +	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
>  	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>  	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>  	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
> -- 
> 2.54.0
> 
>

Hi Yousef,

Thanks for this.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng 
