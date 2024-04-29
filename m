Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E253387
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392026; cv=fail; b=pjh8ZFwlSet4X+WJqAb+hj0HXHlT8O30BYP6Ojexqu7F/gd2HV4FYA9RisHQF5beckWg2PrIYrA36psg/g0LPMMK1H0v6jQ0qIqXXSkL497MUgFDO71eLWMWyAZ0dhcgVmgcGt3Dzawbt2U/W3xqF2ElpF32JnNwcHWBlMNU+Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392026; c=relaxed/simple;
	bh=xNgt43nDhAdBhBrdgLhHyKh2GNrypKy+tDVwPoalWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2DjDZ3rs0HyhUmb/A/YPu0rQeJg7+2g2sEfRwnwygCRl9NbzT5/ssGHRiGTc6bn/Tp6nf7XQCADwWJFaCDKnOAw50H41tnGtPlXjVrn7OlT9iRNALEMFsLgrHKd6L+J+RRu/o0H07rZIK/vS+ACmEPNE074jNDHQPjuU8bhzGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3qq7Lxi; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3qq7Lxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1EaH8zDr2L+zsStZeMt5b8eUBoez3XYjwLtZ3R5U3HEpfEznPrCnNL3S3AvjxMxYm/6BTWtSlmW7RQKJMys6P+E3gHJkjWdzsDpHIhDIoP2nfdu6rJNo/3tMju8/oZItIPpMmKIbUTCysgxWsSRbkPvRJwQIck11EPOYwS8FvYma0xbbJ7/jVMpy0aLCH8+y2bOyUCUwtnsaw71a8jdmpcChOQkrxtnGNYq2Fm/6vYj8O1P/BbQZNxkc0ury2SPk8KhaMzKuJfDi9xlz2StxqT/rPzmGjTgGestUaGB/D/TQJs1uCZIvByX2++PkDo8uRr6nILTdscECDSDpUJtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVH1Y4giFeftJNEn87lNDi+RtI2LQAzebPDtvN4rHAs=;
 b=KPINnGc48v1zGvZegdqECer8LKBUBZAkHXRZrxDCOw4awhx1OxgrTtMQq2LTdfHfnB8J6T3hy7LBKQII1kQv9wz100KYhw454CctSZDvabHio+m6Lc7NJ7JoQRN5VmdraF+jObV91dSowAXg/H80jTBc9hYhedPE/U4kGVJodUQcSEWrH6t7nePDl6Qmo7iuYfwxTXNXXlMaXcDh5hkxWXapOMEEhGHvORrj+CYn1PNn/D5b/hrRFrmNY9uNwqz7e7/u8uSYDjl1jQcpiCtmjAFXuwx4giNAW/DJoIlynQ/QEo5NhSVwfYo2IA7UhCOCSyawQu7xHGgGRlReCSDvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVH1Y4giFeftJNEn87lNDi+RtI2LQAzebPDtvN4rHAs=;
 b=E3qq7LxiM3XkTdMfmDAAssz1/dpodJlEOFnezvM8MgoQLhDJBuw52nNxSkT3tXU/OrFuaWay5N5Tv26jtqxGmaCGTIsyh91vzt57B1WWiDjFJJP7ytPclarqniSDm0Oof/gBxlNJBN1Jf0P1J2GJD6wg0EI8fxzUSWOjlQVSu9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:00:20 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:00:20 +0000
Date: Mon, 29 Apr 2024 14:00:14 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for
 RCH
Message-ID: <Zi-LzgrCVHDlIBpB@rric.localdomain>
References: <20240426224913.1027420-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426224913.1027420-1-dave.jiang@intel.com>
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dcb829-7e12-4b1c-57c4-08dc6843f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMP5Hj4RIcsSE7C1FhbQdIiFwuBgWDxAu+2+ura6nv492/XM4jall51eMWHw?=
 =?us-ascii?Q?WBpcIweo9QBT/9qI/8Kne623CIHvIPIibD4ewuAU/f/Otw+YFTul3ybIXEr4?=
 =?us-ascii?Q?omtA+22QO/8AK3A24Ip1DfwNIQNIxQv/B3cQ0KQLTFJ6MsJhRGu1tOTMWRNj?=
 =?us-ascii?Q?0SKWNO/P6XPMvZGj1cn6neIC+9uG26+mlnh6jFtkQP0m7Iod0PX5UAvtOWYb?=
 =?us-ascii?Q?/nLHxspuKeIirsI13jhBI7BfMs27I/Vd2F8AtO0AtgAcoxuOL1ILVyBcE6XJ?=
 =?us-ascii?Q?xXEpjRvJ8amNRkTCGUkjDu1nIbpgkAFwkipAw3uizT5jcKNo16MnHpxI2a4G?=
 =?us-ascii?Q?I4Wr1nRDn9z43m+MI0J8OYhw6AdpEOPpgwUgUW7+qCmWX39ob0ryz5W3lGRf?=
 =?us-ascii?Q?aYuGOA8ePb122ThwA7ibq+dH0lu8d0EjZuEOiY1Y/Xn4WjQvFN1ZVbjJ6/6y?=
 =?us-ascii?Q?pFf+5gGjpNizbSUArQ+XivamBkLy+6UBVlycKTTsk1TDCn+AoDPFIdkBOL3m?=
 =?us-ascii?Q?VKvuirGLo6Xzp1D5tiZ28XTbBXp9KZArwHe3jdI68VgNprZSXH2DLJWmfV09?=
 =?us-ascii?Q?snWKpQKAaRhjhUYvUq0IvNYyQkUJm4SgYFJ3cnmLUlX4fzsFozmtL4/MXqX+?=
 =?us-ascii?Q?1XfDmEsHjagVh3rAYv0pPzKnhPmPhtPQo/ATy0IqNkMKR5LPk4YbkR+TR//Y?=
 =?us-ascii?Q?G905BqEg/UCwp4Pf5Gv5dm4XPrnBwkZHjpGKZ+dV53JnmoNDoXHtsRrCSu69?=
 =?us-ascii?Q?RpA4Ddeh+5R91/h2+9bqjkhyy6nAjwdW+/ocbbJZCguWxrgJkYuDJW9Cxn9R?=
 =?us-ascii?Q?8WZCzgQtujZVKJj5LQWLWWRVrz34ohiCxpb/EsD5q9m/mRkgVeLu4jqkGZ0V?=
 =?us-ascii?Q?04RSlkEyCNLebWb0MjCYDlqB3uZOIlXnJrYYBcxL4J163bRBfVdfQpbyVL+8?=
 =?us-ascii?Q?7zdQU070i9TtYxwgd/t6CfTVXJ1CpHHEY6viX5c3obnS1/G7jxFkH6aZPOPL?=
 =?us-ascii?Q?nvDrayPWWVRduRFFB+wMApZxGGw8RaC2Q1jyUamVRG8rAWLBpMs9UCXzRv5J?=
 =?us-ascii?Q?GS7GmUs+zwwN938I4aOlChno1JpFku5HzMnBCmblDs7oVRYqOT1ahvtpbwEd?=
 =?us-ascii?Q?/vpgcWOfwMhRrY5I3jQnw+ADuGXk51MYLqxVsxPqFPJj0yfM7D0IGmiGGEiX?=
 =?us-ascii?Q?N8nsJVWZoKo6veab+uYwHGZo2jjB2A2YroquWcWe5pOTHsLW4RVFFRXU7AE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGMr9oxyTnkOgNsJiYSViBxaKv5X8Sp8Hdzq9iVtwr/EFXWB18wEaBwKoCXl?=
 =?us-ascii?Q?cE52wVueYgWGstyIyKn/wacAoSaHHfWqhHhQDpUA4i5cUoI2vE1UsPgP6u2l?=
 =?us-ascii?Q?XtmKLN/DZLhFtMPra1onLA0wQx/ZCd1Peh6DcRY7/egDbbAaWbdOV76Z+LHg?=
 =?us-ascii?Q?nQePHAl90W+JMG2WN7If+qi5EMot9i08OwO0J1p3oT/fK/s22akFR4kaRhU5?=
 =?us-ascii?Q?kn488RWJUyzN9nTeXAs/D2K7hgYlJNFt/QGx9l9oloA81TAVfnBXvBXz70MX?=
 =?us-ascii?Q?8rfbstCALUuHj2omjdrDJNafGLkcf4pTwfctlKGjmvu2C8/gd54sCE3FkSy0?=
 =?us-ascii?Q?NRGKkQi2hrTxscJRs13zFqKzGI4gQQHhox6YtjMgHKfqnRxa81PBZBZATKB5?=
 =?us-ascii?Q?5N7QGoSXYfMxAr4imexgVxFjxE2RFrmA7TctLq755NYVtOKInS5+/07FeB2l?=
 =?us-ascii?Q?haxVsELR+VWWozHneoR/8a3sz/maFay0PshPXZzhfIaAmAtfJH2PS1R6pr47?=
 =?us-ascii?Q?5c3OQS6PPBEGHgq/42nuOFDS+6IHlKl875EqDyAq100az20bdJhQQGZ0fb2z?=
 =?us-ascii?Q?wphkS1DL1Apdr//wdaSWsXX8i1PIHcV1J12ps+b6htKPJRU/jYjaUUAbqiy5?=
 =?us-ascii?Q?KUauTJ4aEzNEIjEZyRanMcthf4vrCW9MxD3vo28cM1bVuVCuPTSO/LnADuz/?=
 =?us-ascii?Q?bzoqQ9BsV7SqN0pq07jZQ3p0UbvfqMY7QqbkwgQrPE1dqsIbffhxpxZMPtSt?=
 =?us-ascii?Q?LXHt/9Y/Hcgrocuca+DZEVsYuNihPx9IxyuZCcsW8XyY/+rUf434P6ZroqOB?=
 =?us-ascii?Q?Z8BHBODRsCb+VFhYeCTUbfsb+n3r8K43trwiJeIW4cYv0B4gHYGdWaFGkZJY?=
 =?us-ascii?Q?0Xr2CRMC5Ack9dqZLULkWX23yfSn9Tx9dPrJojnlwOzFVzEs4KrNE7NVk2MG?=
 =?us-ascii?Q?5mPxlub4Gnoda0YnXKH+Phd20YFLYmH6HBKP2XQ0WJB0P9ed72FCytAsI1wp?=
 =?us-ascii?Q?wECvQiyCFmkWtZLn8wha3jtvSiIv1KKPV7eVK/dbQi5ZIrOeeoEIFwv3OP3r?=
 =?us-ascii?Q?RwiHLPFDsG1MyuNNzfK57dS+IoakSVTtQblTcBPQjghbcDeR31IhdRkciRSs?=
 =?us-ascii?Q?EBF+KNVPdS2oZcSn0W0oc6lz8E8PS+6TuzjlUBWVQ7AYFJR6h+AVEvsTGl87?=
 =?us-ascii?Q?A742cZ0e/O9Vvq24FzCIJZ23lb5O0VK+SZt5BmSDKdv9+94nW6ilukEfRGib?=
 =?us-ascii?Q?sC+y7WctogLtoPFfW4qBXBzqhyJmoqomaZSARAiYSCO+MLBlWWTXgojrs5iO?=
 =?us-ascii?Q?APL3nGJYE5HUcD7b2Ar/4rQtwVp+t3tBK+DRw/iTsHgy+YsQDmKgdyqAqwuV?=
 =?us-ascii?Q?368k/IFgX3gWWkPjKShravJVArycXT5XSfmoz3FBoM+fd9toqEdykoTcktUE?=
 =?us-ascii?Q?9uzvcrjBQv9i5qEU/ioyzOO2PXTITYCNqPCZ392YUVu7Z9fIhT5rZUfWTPsT?=
 =?us-ascii?Q?z7t5arKEd7T60SM9y6StU65ghoSVtwkiXdK8jDRHOhi5pQ+xz4SGDucP5UBD?=
 =?us-ascii?Q?/yqtyRur3ImVke9qoeU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dcb829-7e12-4b1c-57c4-08dc6843f176
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:00:20.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gHqTqTejWRIOWBXblVyjy11le6pouxyehZLMT8EUHcQ3N4Yy1eLTEMls6ogFm7kYUzepLumuD3I2fLBNOIHeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

On 26.04.24 15:47:56, Dave Jiang wrote:
> Robert reported the following when booting a CXL host with Restricted CXL
> Host (RCH) topology:
>  [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
>  [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]
> 
> ... plus some related subsequent NULL pointer dereference:
> 
>  [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8
> 
> The iterator to walk the PCIe path did not account for RCH topology.
> However RCH does not support hotplug and the memory exported by the
> Restricted CXL Device (RCD) should be covered by HMAT and therefore no
> access_coordinate is needed. Add check to see if the endpoint device is
> RCD and skip calculation.
> 
> Also add a call to cxl_endpoint_get_perf_coordinates() in cxl_test in order
> to exercise the topology iterator. The dev_is_pci() check added is to help
> with this test and should be harmless for normal operation.
> 
> Reported-by: Robert Richter <rrichter@amd.com>
> Closes: https://lore.kernel.org/all/Ziv8GfSMSbvlBB0h@rric.localdomain/
> Fixes: 592780b8391f ("cxl: Fix retrieving of access_coordinates in PCIe path")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This patch fixes the issue.

Tested-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>

But see below for a question...

> ---
> 
> Hi Robert,
> Can you please try this patch and see if it addresses the issue you saw
> on your RCH platform? Thanks!
> 
>  drivers/cxl/core/port.c      | 15 ++++++++++++++-
>  tools/testing/cxl/test/cxl.c |  3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 762783bb091a..887ed6e358fb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2184,6 +2184,7 @@ static bool parent_port_is_cxl_root(struct cxl_port *port)
>  int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  				      struct access_coordinate *coord)
>  {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct access_coordinate c[] = {
>  		{
>  			.read_bandwidth = UINT_MAX,
> @@ -2197,12 +2198,20 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	struct cxl_port *iter = port;
>  	struct cxl_dport *dport;
>  	struct pci_dev *pdev;
> +	struct device *dev;
>  	unsigned int bw;
>  	bool is_cxl_root;
>  
>  	if (!is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> +	/*
> +	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
> +	 * since RCH does not support hotplug.
> +	 */
> +	if (cxlmd->cxlds->rcd)
> +		return 0;
> +
>  	/*
>  	 * Exit the loop when the parent port of the current iter port is cxl
>  	 * root. The iterative loop starts at the endpoint and gathers the
> @@ -2232,8 +2241,12 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  		return -EINVAL;
>  	cxl_coordinates_combine(c, c, dport->coord);
>  
> +	dev = port->uport_dev->parent;
> +	if (!dev_is_pci(dev))
> +		return -ENODEV;
> +
>  	/* Get the calculated PCI paths bandwidth */
> -	pdev = to_pci_dev(port->uport_dev->parent);
> +	pdev = to_pci_dev(dev);
>  	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
>  	if (bw == 0)
>  		return -ENXIO;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 61c69297e797..72e2ce58e1dc 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1001,6 +1001,7 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
>  	struct range pmem_range = {
>  		.start = cxlds->pmem_res.start,
>  		.end = cxlds->pmem_res.end,
> @@ -1020,6 +1021,8 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
>  
>  	cxl_memdev_update_perf(cxlmd);
> +
> +	cxl_endpoint_get_perf_coordinates(port, ep_c);

I don't see what this is for as ep_c is unused later? The only reason
is for error checking to see if that throws some kernel message in the
logs but return code is unused.

Thanks,

-Robert

>  }
>  
>  static struct cxl_mock_ops cxl_mock_ops = {
> -- 
> 2.44.0
> 
