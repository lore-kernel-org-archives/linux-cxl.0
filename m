Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A463911C9
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977490; cv=fail; b=aclBqSoELO/fDU1CZUTUmpiHIkUR/lhn0GeZxhm6/x9U3JMHtcJBZCiWw6CrsjOH+o2pOS0N59E7gieW3R6CX2wOSS8+jmGrZawblDhye4nECvEJ/omwEKs4n/FkFE/yd6HYFZoDsHH7citCGaMPWh6pVh9o2MTWq3GGW2MYm70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977490; c=relaxed/simple;
	bh=s9eSXT6Y9caLp7gdQQ9ClVSVpov8bn1rDUoWRJkAqs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R9NdvFmQzNlkk2M8mmPZBswXTqQWEM2wRTLqaiEbmOPdu0h4MRvNZAgIH9d38+FVouFHveoXdW/80zHU0/PEgo5AU2+TJZ4eP9bEVOJ7pMnGAOkUUQXyi5QpOJjirFpnAgfbs4Oe50gfy+/84RdcBOaZUOXzcfgsgMwmUDWxP7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsH1mhns reason="signature verification failed"; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsH1mhns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf4BUHJdP9psjTQasCRsdnJT67PmpxmXOn0eCKaURIgn1Yct1A/35Ln5nBq9a4keAhRLARjvZY23jbfKRFy5704b/6hpt3CmEfzgm3aa4Uj2bLYtbFEwZB/4KnydacNCcAhvYyNmVnyweTmV1yPw1I0Hfad+6sPH9xKjSNGN6hDJF/zEVZQHQ7IMTJPCCCfA7mopZUWu6fdfCC+thPz4a9lByj6re8RzwcQVLqHDUNNUK2LlKIPIuKd+EfzEo/uWnnfaYL25sREYTVSS7Nlkr1I79TJHTQ58T+U5A63GPjBnIvg90oZ8/Q3OJL0sgGSG4B24N7R4FTChAjPXWZdUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDASgzq2jUIlNyFdvcbrtROXrfvUOGAT9mzxJxH8O8Y=;
 b=iOJzrodnnytAWQasFjn1vCjulAih350CFoDwGyHjdHcxVVafNdom/Gk+69RyZy7olSiEbYJv6qfGxBnOi9N3jhJgAp7udHS1qLzs5hGbuePm3GdrR70qfI9i4zhwtrFVDQSFFjY097qL2HTTUNfPeJP3F3+JO6yI43/rKci7KOUoVF9T/qhalExfU18Wokhrnym9x5IhcVfQayGorev2bVAZRJzwdkGqLboOdj+bYJHTXTePmWw8KH6VmQQaTfzAcCqutHIEyKdkYa3jhgUNudwU+3/A+RU7J6d9Z0gPtuNsUnbfCwblOf5ZAwCcIG195FX0f1wlMp//RJpv2MmLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDASgzq2jUIlNyFdvcbrtROXrfvUOGAT9mzxJxH8O8Y=;
 b=LsH1mhnsgtYAS4XqhRwRiVomQw1ochQ9aH/GQv99KCIKTVquajo4zDcpI+A5pmGjOUNqZ4KHLWmo0JSkZPRAKELbjbnF/IYsJOl5qiHFFYdpfP0ib4vkkDo5q3NHHq1Vk4TRxzkCcPC2RQbChsYRcnyEq0MgI4I4gBKgcF2v513pe0HRCAeiM3Rw3rfukHcxKSDXiIfkZTtEIb5SiQBG2iTB8jW/wDqEAG6NOFXdeo7tJgF1y4g6k0oYAh/FyJUmN4+DUxxu50BQI+nNhBD1kx4eE5GdeCi3fD4eUCQQZ3J7uDCFgyXsnZkMK/5XzQDYMFwl4GZyZ8P2xy+yvQVQMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 07:31:24 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:31:24 +0000
Date: Thu, 2 Jul 2026 15:31:18 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
Message-ID: <akYTPc5texS6oUo9@MWDK4CY14F>
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-3-icheng@nvidia.com>
 <20260625094602.8DB0E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625094602.8DB0E1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e0a662-0e21-4cef-26b8-08ded80beb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|5023799004|4143699003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WoyWpTuXFWfZ+oO2JfNwU+CD1+sxke+qRI7GVIkZfXhT9ISnFTI/isX3iowY6SzgAuHP7ALdkFe4gMOAxUuL1uEJ03cj590FcZuVLdp7Kp8WUA1qImdBxI98Wk0ZOhcs/bXUsOfnXHgF0MW6Myw5i3e8r5ZJfs1saxBPFOnkjSxiDHRa5eOSZjUM+Pw7OGKbn7N9/plIEHeYSQkCKfFt2KErObMpKN8dOC+dsxyIYQSatRaudsggvpNGRiwYt/ao+08FmkHyf2OKTcG4t2e4V6mweFwsmao9E2Pd3hHsWVUyPk/uGgi3Lha49Inju+lcMGbV0r33P0wb09CCUZbL5KqeMmwkle4rkKKp8aRPq8arOmuhl6L+moE/hd/hndE/9eQkl6B6VPZtZ3bWw7U5H1Dv9TMpF9UDZajVL3zcZ7GmNhCm1l87QLn8aCciXEKwv1z3cwYOTLBJQFCO8LZ7iOUl0jJKbz8tDsL0Mwj4AkHMv00i9nwIMSOG/p4yLIOjxZ/XY2IWT8QkQRA+hjJdTye284H29mhlG8+IJmny6qytKeTedMJse1uQ/qwNRGxjcc5LnK7XU7Q0TfbQDtEuWfxK7ROjFddB6HnUC31OuIe2IDrGmLVgdJAtIP+eOs44nmpmURzsudc+0EngfVKv81/rHNPMLuDMASpUxNfdGyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Vl/HpmWXTpUzHRqRQD00O07k+jexrANv1La8g31Lc8gz23mpi2Z5B+3Br9?=
 =?iso-8859-1?Q?rXZpMeUQZw0BW4WIaipABfF440riXOPJZmaCcY581lIFQ7vBx5cyeGXzju?=
 =?iso-8859-1?Q?dMhe3A0TUHF7B4erKIGVm1Kacd7dC5VFehNK6NWaVtrE/Vd452yDh5Q9wx?=
 =?iso-8859-1?Q?tJk7OWQGvpFrCvxRy/jRIEIWFNIg1gBueZDJk8zBL2Y1fDWmMoLS2iYKYW?=
 =?iso-8859-1?Q?xqvEWd+WbPBoePSoasWKdEFq4nZECEraCRvGZZBg5Vgs59TeI0fEyjsmhR?=
 =?iso-8859-1?Q?RIC6bQ/IDYXiU0JfXYvKOVRy654CG8JA19U4I/Ba1Jmche2bhIeN/K8SHi?=
 =?iso-8859-1?Q?VP+mObQoXDRt36qPpkranJ+6Q6+65pfmmQycbISmbxK4TXTpGPTMuY8C+/?=
 =?iso-8859-1?Q?90JzfpPva21ez5b96qe8lsWEIfwyQKYUlbpUiKsxAoTT0xDIvwv8LkkWEY?=
 =?iso-8859-1?Q?uwqhnxfjkPN38o6ddOBAOLe7oRwTX65vpDw0Sq7fzqFrQmN5vK75APY+bG?=
 =?iso-8859-1?Q?22yCY06DFlqpUpHi4ixPi/jqtTrUl/IxYi2vhEyaXF9ju5wwBs78X2HQ07?=
 =?iso-8859-1?Q?LIoatGdGB06gZmRdFXjEl3ZpWQNxybu5XAT2bpBJOkKzz8rAqvQHGYMQTB?=
 =?iso-8859-1?Q?vfg17h3wZEBk3wFaqtdiG1XRWUsfPEvwq2Tnsbt/oP0T074qqSOs0SPh39?=
 =?iso-8859-1?Q?Nz8AIPD5ZLVquJ1uYUtbE5W6GFnZW34XZU6gtl4E1hCR5hY/A5GxJf14+i?=
 =?iso-8859-1?Q?h1mwqDCZHrlcWpq/QU4nR7iSxF8x1SbXS1qZjfB11K4+plYsw9AWq7WcAZ?=
 =?iso-8859-1?Q?hQGyXeQrw3ogFNlCgTdx9gdJrvUMc6+Z1l2onVR6XAG10PXt0UWvFlCixo?=
 =?iso-8859-1?Q?QOiusGtQSHhlVEgrThdBZNeLviLXKHbfYMqNwUuPPEug7z74SBGY5hVBxj?=
 =?iso-8859-1?Q?lW84BUaXN+n1tdgpcc46yYIBXU6Qrt/9rLFPTGnEDBMNxhCw8KQWosNIj9?=
 =?iso-8859-1?Q?zUWvesy91sz4oLyCfceBuA3LpdBQg4wW/PzhRSbbcUNrCGVnf/tjI2WHQJ?=
 =?iso-8859-1?Q?7yVCwsX5nOX0pDxToDWKn6GtQ8SFK7MuvxJyG2vPy2vRzaIGTVNBgiJsNc?=
 =?iso-8859-1?Q?4QWWBqs3xIDtGhZqffdzluJFNhrs3uNv+nU6LUdSCTXgFC/KlKbiJxMORQ?=
 =?iso-8859-1?Q?MCzPuxiYfCgjde9OMejQkdGOGNbgXS4CDB1v2SCmksIiC2JUbKoLRYxSgH?=
 =?iso-8859-1?Q?zLsGRyNNHjf6/AM+fQVQJmOJ64qsf07oPe+lCnYjiWaCQBz0s8vyPcMrY7?=
 =?iso-8859-1?Q?Ou/p4CPUkhRLx2xFBo9XPADNkhGHw9P0852ibuF17T9uKfB8JwP7NFUNUT?=
 =?iso-8859-1?Q?TCQLz7qXw8Ww56XgfQDd6Omj445ozHnT3w00GUamBTkKm+T86iS+rtiUC9?=
 =?iso-8859-1?Q?v5MtEBc8pYX9ldS8jQniMWfm5XirnxLEP9qU8k6P4sYrThLM6OPtCaFpu8?=
 =?iso-8859-1?Q?Oh3O7HSD215wbZ8oIZHOocGswydTKevgjhQbQ3P3pn2TJcksBW0nAp8s7f?=
 =?iso-8859-1?Q?LHUvQoH807Lu4AM1m87JflRQzXpBQTDxDQpVK1e+/217+u3+m5Ks9VW9LC?=
 =?iso-8859-1?Q?jt6EXo/2SuR6jeazSpmoiaDZNQxD3llhlPcprQopSKi++Kh0BYbrnL4UiK?=
 =?iso-8859-1?Q?rd80H63GocAgASh6CWFNZvnUv7xwFVXGIy30TCGL4qe9SCV2WJu2w75/+B?=
 =?iso-8859-1?Q?6dI9K5ByYR1ZyWTOU0lJBt1QjHYKLseL/bfNv888kxyGfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e0a662-0e21-4cef-26b8-08ded80beb03
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:31:24.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+UL65OvuiVBJx9aYERJCvoxv5ehzlKYID9yTYmW2H3awZ3gy8Ywq+UNA29NIadKYeWg50HKKIgvoMWdNdw86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On Thu, Jun 25, 2026 at 09:46:01AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect HPA base for zero-sized mock decoders causes them to overlap the start of decoder[0].
> --
> 
> commit e4836660bfdfee0da74cc6f18fe1e3c9826c4c04
> Author: Richard Cheng <icheng@nvidia.com>
> 
> tools/testing/cxl: Enable zero sized decoders under hb0
> 
> This commit introduces a mock_zero_size_decoders module parameter to cxl_test.
> It is intended to exercise zero-size DPA reservations by mocking committed,
> empty decoders above the auto-region under host-bridge0.
> 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb00..117691b3c62f5 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> [ ... ]
> > @@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	base = window->base_hpa;
> >  	if (extended_linear_cache)
> >  		base += mock_auto_region_size;
> > +
> > +	/*
> > +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
> > +	 * endpoints mock committed, locked, empty decoders above the
> > +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
> > +	 * points at a zero-size decoder, exercising the zero-size
> > +	 * reservation and poison-by-endpoint code paths.
> > +	 */
> > +	if (cxld->id == 1 || cxld->id == 2) {
> > +		size_zero_mock_decoder_ep(cxld, base);
> 
> [Severity: Medium]
> Since the comment indicates these decoders are mocked above the decoder[0]
> auto-region, should base + mock_auto_region_size be passed here instead
> of base?
> 
> Passing base appears to set the zero-sized decoder's HPA to the start of the
> region, causing it to overlap with decoder[0].
> 
> > +		port->commit_end = cxld->id;
> > +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> > +		return false;
> > +	}
> [ ... ]
> > @@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  
> >  		cxld_registry_update(cxld);
> >  		put_device(dev);
> > +
> > +		if (!mock_zero_size_decoders)
> > +			continue;
> > +
> > +		/*
> > +		 * Mirror the endpoint: commit the next two switch decoders
> > +		 * as zero-size + locked so the empty-decoder layout extends
> > +		 * end-to-end through the switch and host bridge.
> > +		 */
> > +		for (id = 1; id <= 2; id++) {
> > +			dev = device_find_child(&iter->dev, &id,
> > +						match_decoder_by_index);
> > +			if (WARN_ON(!dev))
> > +				continue;
> > +			cxld = to_cxl_decoder(dev);
> > +			size_zero_mock_decoder_sw(cxld, base, i);
> 
> [Severity: Medium]
> Similarly, does this incorrectly place the switch zero-sized mock decoders
> at the start of decoder[0]'s HPA range instead of above it?
> 
> > +			iter->commit_end = id;
> > +			cxld_registry_update(cxld);
> > +			put_device(dev);
> > +		}
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625092857.41139-1-icheng@nvidia.com?part=2


This doesn't stand neither, [base, base-1] is an empty range, it decodes nothing and can't
overlap decoder[0]. Region assembly never sees it, endpoint empty decoder are skipped via cxled_empty(), and
the switch matching predicates compare range ends, which an empty range can never satisfy.

--Richard
