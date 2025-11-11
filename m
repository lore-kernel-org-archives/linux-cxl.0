Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAC272E56;
	Tue, 11 Nov 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853007; cv=fail; b=IzsHi4yZSO/vgu+Qw13qwsbDsevhiYU+HCe+phjv+ZwSYvoAKc+qi1G6/RdL+lPaIqhMF5SRhDU26uWSx9eRNv4XQTeVeNTyGOf2w3cm6dluISzMFhZoNngAEUQ/zAm7ycSCl0N4lwwrSqjm9sLwog6YSZh0SbsHqMQ+yXUUuWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853007; c=relaxed/simple;
	bh=ilHyKOtrSytSx+S/9j2oZZKwt2QQqZeUcaPZXDUm5Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgF4kCepeOJn0bhsc2UBivNFvs6CtD1jyiGNm4F9fWPNaVwMj0OYL+QkunDwSLhm4eBbUzDxmFKd7bYwOobFTHL5+k3WESBj4LTiC8mvmCaE7d+ayJPFWaiPgxCKa76uTbCyw/XRlo+lc29PQNPLdmSuzdYk3hvA5mZRtgMAqis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ja2/Wn8T; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ja2/Wn8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0PyLvo5bezVjnk8sxkLY744GrbIk38Fc1AiU8+FIwTqLBOXKlBzESOuzaR9t2d0xNbj5+5qlJ4XKsXDClWo3IjPU+Dnkb2/4I8IYBZbACLeyRrh4lMSkjrp5Sv0oRFq6A53bvdAbxwcc/9T09YkF00ZgrktryR0SmXi3p6+UYZiGKxlHVm3AC81AxrXx3+UE6nJt3EinadCpXGq23UKKRy5KCN0NZCizuwaY4nigDS/e3hc4R/ODzTWGtC0oxD9jHHtMoIngOUsGy5BYTA8LKxoQISRzz1DCvT6lKJrg0skBM5TKGUHNPKJl9Fqfmz1BkF98GKgMbn7R5H1S8y8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzVyyJAPn0MTASLGoAo0x+R6/I7STIQ5pC0PVBmYY+8=;
 b=T9g6Fc6v/hZdaSIfR0/iyQ0zt0iKCTL7PGDfwFUN6vpYOwGi6LQV8BoFWX4SBxhTgUiBzQfY9PktwRGGdHPSMtm287Ps6zK7x+aiFE0D9iBfdy7ox3sVYcNGNcic4tMSlmVbokUS8k6MN9mKay0v7UWRaEHmAlCcjYe4KBnZvs5g+szufBCXGOA01EJtdfAqw77yeO7VAWNuvn20YvLwEpXKBDtd7W2IzWyV617d1hPtpYhCX9cBSLhPcN+66uIM+sPHZul86r25H9PMUe7LYo6Exnh4D5q4ETdQGOCubNVAby9IYYRknqUuEn+S0BDPhGd97Y27aGPwj5ZpoyqM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzVyyJAPn0MTASLGoAo0x+R6/I7STIQ5pC0PVBmYY+8=;
 b=ja2/Wn8TbSJmL1+YyvuSHApdWnwdJqbNPSN3BebAvzzHEztrIjavie5Ia3jbCNbho44iSy+rT/5zz3QQxHbq4bhvq+BHmUebDxlpFwXTLhpECrDI3WAsEfJo4KFqBrJsn3A8nwbEyB4fq5M5N9iFvz9c4j8r3C64i7nDlspO9oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:23:23 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:23:23 +0000
Date: Tue, 11 Nov 2025 10:23:51 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aRMAp9dJ2CcL6K7L@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-11-rrichter@amd.com>
 <d752b9b3-c032-41c5-b10f-48b711a54eee@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d752b9b3-c032-41c5-b10f-48b711a54eee@intel.com>
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1139f47b-7463-4933-9a7e-08de2103f63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tfVeqitDigjr56nJrhfXiZbqSlZpVwb5tCjQ6+j6Ie175RBU7rK4BHtZjvf?=
 =?us-ascii?Q?++fRF7BROlKCNCLvu8Rw97HY03pVFhHf3J+Plqqf7U2Xipz1L9djooR8AHHY?=
 =?us-ascii?Q?dMnEurbtN/tPOVlgqPzj3qjHPdRj/5dn2Z4ItFWyQYlgGoLAW/1gcxIXxoTr?=
 =?us-ascii?Q?Bg2lFLho+/r6S9OB3P0L6YIVYUiuOhqt0tKgnq/CHVpGeXzTO5o6e4PDt8PF?=
 =?us-ascii?Q?7XZNH8i6X++pqMnRHWdwEX6ZSFgsVoWcC8imrHWbDUufIZll2aOc7U3Vx11U?=
 =?us-ascii?Q?ziwMd7sPB4lHqQ9IC/ML/LyIceT3lI8Fx6yN+ukEaLxp5l3wzlWEpddWtQvA?=
 =?us-ascii?Q?x+k+XDYPY5LIQ8fNcfuoZfmM/6LFRMLVw2KwJ4H80dr+QJfE9ULWtArMo42x?=
 =?us-ascii?Q?6rLKf6VB8cIXaZ1zUmLvaGNPv56abAbOJqXEliD4b55xpsFka6jnFmG56jhN?=
 =?us-ascii?Q?8VRICwiNZJ/jgQdNPP/JA6NXiVhUGFoPwOnaGxu+bd+WefS5EKk1b9kOXpUK?=
 =?us-ascii?Q?GwxgaMSGXBBAuB3+bSeexx1Znna9ytCQsk35a//HCtlaTshn1tKCN0ecAiec?=
 =?us-ascii?Q?v/j/n+34vq9fddK/Z5sqsUKWirhjL6nIIMWtBuiGo4e+EN62pQwoZNXCGop+?=
 =?us-ascii?Q?i+sMYH8VTBOTW/DH0n+fEYos53BZoeLFiebXGAP2vgpyIRFZjfgxSqkBlUtD?=
 =?us-ascii?Q?hf/3RpHzL9YaQFJgqJ5/ohyzq9aACznwnfCpaQu7lb7stBOm0HbQcB/UJkz6?=
 =?us-ascii?Q?JQxpxlYbJ3UzuhEF5ziwimkNQ9F9ybyUJIrqzuNtXt0m4ClUJJxnO4BRXmwZ?=
 =?us-ascii?Q?XNESiktCZ3rbNqQT1sCKZrfsYu8/28XzFJdt2yNSOEkKbSsR5ENDaCLNLWaY?=
 =?us-ascii?Q?tzPCvTlR/r4RV4sG+jf/7ynpU+/b90B9Y5lxeui9DCDEQwXFPypouXcBhD7c?=
 =?us-ascii?Q?QvU1OA0D7S3jB3iSWS1D7p8HM+TO+YZeJRXCBGhTFiZOn/HhnmHtj8/EGwKe?=
 =?us-ascii?Q?yieRf0skpD+Zrz/oDdRgo7rzvf08Au0FRMYv8maDXFsd0qwmpfMaveGt0sG6?=
 =?us-ascii?Q?nXMoodC5t8DjNXdk8SdwwEwBLtwIQElBQAJNtvxlHIKYNFtFj2B7qLOAAdF9?=
 =?us-ascii?Q?1N+ssyMQJAbsq2C8rPIS9KontHYHLKqwKKZ0eSw3TF+aPErOwmRFIScFE6dx?=
 =?us-ascii?Q?r+547dnL2MU2UXKGKG+InqxASFL7WYuIY70fzz8/y7SlPrxG9qnvCBksAez7?=
 =?us-ascii?Q?AVPQAsYlEblMnLbN2dDYf/JyCtjkuCAUlOiHq56Kt9CH5aMvllF6LFQ3N81f?=
 =?us-ascii?Q?+LXpuv9Im88H0fAgbaw7WwGsA/jp6pwoKTdAT+kJ+6zSQi7i2RhsiKVpMWRZ?=
 =?us-ascii?Q?gvNdF2dwr8e+y1ZBK8fIXtCl0gcWnwlIJup2lkT3d4RtZyhtVxUNqe+aJsnh?=
 =?us-ascii?Q?UOfUAR/9xmVsCfU8bS6OMabPAMP+75JL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CF65urfzMxfihgLiC3sPs/8hDRlmhpXzwq/jfUP75xLgYijsByR04U7lz0Pg?=
 =?us-ascii?Q?Z+ByG7ZUSq4t9BK/Gi1P9pYfZlVE0F0+LOaXmBgXSKez4J3UdH/2B4xhi4VZ?=
 =?us-ascii?Q?YTcSnc9fDM58NooB/CbLhKj84iHGcTQblraMXDWPsYWFVgpbxxSHZW4iGia6?=
 =?us-ascii?Q?USLcDBfzCrBY8bsl4PBHG6hCu5ab23Kct0nIKxM7uhKFUOyRZUehpcio3BwW?=
 =?us-ascii?Q?wPRyI13b/JZVLH5/P4ppRZ5ejwd/JnAqMcJxb5cjMCcuMYqmrGRvFnjYxRRU?=
 =?us-ascii?Q?s7qy9+i1jCd+9CN4z5m46YFiyNQzYcOkDGgbIomrbP8oCFF8jk9lxMKyWDT0?=
 =?us-ascii?Q?+5fAVCzkFquHAjdoXYQCBGtuqMXm7nhnCzoa9OIeBTxnVr026McwVQ7Mn9bE?=
 =?us-ascii?Q?uVJYmElKOrrJbua4yIoIjNr00xH9O72whWdvb151CSFS9otg2IWIB6D+Ki+d?=
 =?us-ascii?Q?50J0DqO/tWCzicHcQatR5SzIa7nkzaqH6MNr9wQsPdGAKH3iLVmi9vd9kD3S?=
 =?us-ascii?Q?AkPhs61C8uWuU0TmS9Hf6SpNDmV+Q7ix3O+6A+AGi3zLAwAYdOA8SIv8uGd/?=
 =?us-ascii?Q?uXWOTb90NEKjo+GZH2RATjh3SYGgH1qc5W7XN+gQTtw1QZYqqWKpcZEsv/Rw?=
 =?us-ascii?Q?QlLuGah+1df7SEnvDqfF8Zq7wBoO7fs1hxSFg/6p4UpX9kzNO2eWQW46XW2e?=
 =?us-ascii?Q?Hf2vvS1R4W/OHpgkJLW82WYa0Bzg8dyMrTreJ40fKBEIeQWkFkhuMxnEd/KT?=
 =?us-ascii?Q?j4gm8IEX1pJQqRzIGJ5azhmRFOtr0WmaW29bC7dtedMbGytccyYoPjKip229?=
 =?us-ascii?Q?vaDLLjtbKkKx0gWqdY8DEqDSmgXUrl90neglAje8U4Qk9YPT1LlG0GTnpMly?=
 =?us-ascii?Q?zWtwqVl+RPqdrAEzqPvDuG1dUiSlCVG/GuPWVceGo3j4MzCkphqw4O15Pe0M?=
 =?us-ascii?Q?r/v4PdgY96/1mXri+j2A8VwbcYKZQuUz2PYlwFktCGgsSKpEXQBws/Mi6D0G?=
 =?us-ascii?Q?ZQF6C1fZqYe9zYSo8quvOWp4g/7+Cp12B/IAzPiTkYzJi2oBi1xrgHqnwDVv?=
 =?us-ascii?Q?W7aPSy7hBd+jSem3qNt1prkD0Hz5/h1mWIOjSZk187hOnyPEMDoXVHTRV6uF?=
 =?us-ascii?Q?vGrc7vn41f8/PtG0vs9DNheLcDgjEN+ef8c98eIf7oZZHoAxCH+gGj/hqV5U?=
 =?us-ascii?Q?oWBdDRSRx4Oj18miK/h5mtHtTL+N7kw/ZYlT1bJCseMkIC47xA5NOTc8BQwU?=
 =?us-ascii?Q?08QzucbRzZg6uuqpmJ5uR6Z19SygVivF2tT9ywavA7tFOcMSaMJwbO9ptuyS?=
 =?us-ascii?Q?fll6DWUT2kp3b4ByUPh36zpl7YiXMzG3w42eRYpy4GFmH72u7yP9FFAhSaCf?=
 =?us-ascii?Q?Pq8gyblZlEs2JRQgUgn1FR37VMQ/IeLdlBJma4dWF78bFVQ3z9E/lEtMDw0M?=
 =?us-ascii?Q?UgQ/ieEkQuUtKQRHs0SNk5TbvR6jEls9B5sVoBn5dVAH9V2a4fn+BdxnOVgz?=
 =?us-ascii?Q?VDS/CJ19qMnqJr8V0S++Bv0+XisbR7y2o1raH56GrtTZUryGpLwA8r+ALOGb?=
 =?us-ascii?Q?ZQ+IntuZN/YTTmUsXXwmaWRHun3YfK4lKgh8X/yo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139f47b-7463-4933-9a7e-08de2103f63c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:23:23.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0vpt5WfVGorvHmT7Lb/YVSs4UjPfXv48hGYOQxho6cr5sHQ6re2cdKrJLYDRucNfRoGzsT6J25W3Gw5JLCVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

On 03.11.25 18:00:08, Dave Jiang wrote:
> On 11/3/25 11:47 AM, Robert Richter wrote:

> > +	/* Translate HPA range to SPA. */
> > +	hpa_range.start = base_spa = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
> > +	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
> > +
> > +	if (hpa_range.start == ULLONG_MAX || hpa_range.end == ULLONG_MAX) {
> > +		dev_dbg(cxld->dev.parent,
> > +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	/*
> > +	 * Since translated addresses include the interleaving
> > +	 * offsets, align the range to 256 MB.
> > +	 */
> > +	hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
> > +	hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
> > +
> > +	spa_len = range_len(&hpa_range);
> > +	if (!len || !spa_len || spa_len % len) {
> > +		dev_dbg(cxld->dev.parent,
> > +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	ways = spa_len / len;
> > +	gran = SZ_256;
>
> maybe init 'base' and 'base_hpa' here. Makes it easier to recall
> rather than having to go up to recall what it was.> +

I've ended up to initialize base variable close together for a better
context:

	/* Translate HPA range to SPA. */                           
	base = hpa_range.start;                                     
	hpa_range.start = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);    
	base_spa = hpa_range.start;                                 

Values change an thus it connot be init later.

-Robert
