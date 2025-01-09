Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90C12B94;
	Thu,  9 Jan 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418637; cv=fail; b=CouoS3EL+rstcjlmJOWs3bCX4PdNUXdZhGP5xvhRNviVYk/YrtkflzbtRqO4jFwaYxGO87+SrxQK4wmEmcrMWXY+xbtML9+kD+IAHnqkOZmlX9sD7eH+z5are3u9G//AI4erOV2+GMZB3cK0IcL83jqdfOI2g0M83eiK1ulhFPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418637; c=relaxed/simple;
	bh=rqMRQMSMEbb/AxJMDr1wb8uMdkMAM/tVVRhiCRqEPsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWG3rrKQNw+KNZf/rrH3QDxSIlx/5mr1pVUzVJOgQns7Kky4KOFQH+ORzXFu45iRrnjmIX03Yyrcip4KXu9kzDxQDeuF7m6LbVYJmsIzm46UDXgJHrF58YwExpL3E/F0aM5bTGwXSc9viS4Wi4MNDPAJat4c9+6nvQojXugXvTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXLJytYi; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXLJytYi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFY7nfepvo/kl8PpXlmHcK3FululwwbEoY9hH7pfqmnzJuu/X/FpGzsx1LU2ZfU7Fos5+WYKrgjAyCHtT19Z13r3L54fDlrutW/PHF24gRgoa3CFXECs/KKe9hMq8E872OnljqpX02m97cHN9vQS50uUo9e7fc2ALFrKp69V2WQTdeikD+VqhZM27TWBw935bIKyNXDVlB8aVh8blZFFKJQb3onl6qsy3OTG+vcfnVxU4SobwM3Ul12pBPOtbu1XCnu2Mc/uSyfVaL99nKwMsjbAmAp49LWCB84Npeio184bFEiutuYH3CdGfv4/zAkUTv+M/8NaqGsl/TXWbuJb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxq9IKZQoOuyoviH/NiLQv/e2RXCemFzd3B8uFotzug=;
 b=hw1zTaAa3wL1LDVl31iLn3x3GXOtpSBwaPlWSJh/LxK/fyZljtMVnUUYjEQ9UgjXVnaJSRP2jJyfwonn8VdO9ZSVt9sjyvIbe7PBMlX5t5C0fSFNMQ7RME0PeNrKLC+yjYSmtmOmLiaE4sSkM4EbH6ZkKo/x+n6hfiwTNMzN0n3E8xOX6z0yi6bcdwB8aQmTcI/utEeANgMk3VtJgdBBr3y4764QB3uWTgMI1X2WaUE73oVfwe09DGLEbJPn3ptQLAedcTVcNnv3395FxpqTylj0vj5g8rEHIm8QMFuHQqMAnppGHZMSMiudAIr0w9/gi2uIfZxu5Xi1dKC8dCaEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxq9IKZQoOuyoviH/NiLQv/e2RXCemFzd3B8uFotzug=;
 b=gXLJytYiNfq2nVEkgvwTWXULvgZ7OFVwERkrJrEHkBAfr9hl+7nSvcw6Pv2JRvTMnhH+tMgkwkh89hGxK48CuyHUQ3EOFNinvqH3JWJrwCPuY8o7rTJ3K/x1St06DrW+4cGFTz2/da3xXz+EHFTqb3l/uYqUns0LyaeudLPujG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 10:30:33 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 10:30:33 +0000
Date: Thu, 9 Jan 2025 11:30:27 +0100
From: Robert Richter <rrichter@amd.com>
To: Li Ming <ming.li@zohomail.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 08/29] cxl/region: Split region registration into an
 initialization and adding part
Message-ID: <Z3-lQ6oLSNe6t3sb@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-9-rrichter@amd.com>
 <7a1a8340-a393-4781-957b-9da026b03bb5@zohomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a1a8340-a393-4781-957b-9da026b03bb5@zohomail.com>
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f397a61-04ef-4759-c103-08dd3098a616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+EhmSgbbpLNWGKUa2sFdK5K8rXvRkId6phk/8MJMf8Cc2UhD71qbBRM0+20?=
 =?us-ascii?Q?26w9UfWmkQ9IxZiLBYf8ImG33ZR6Yn37/zg5FqZ9KjnmGD41AGMwEyEpCHGw?=
 =?us-ascii?Q?PEgtkRsZn3JMhnImKP/MRMX5kOL6AjlF29Qvx9PXSmlpnnI3YjlQzqkMKUu4?=
 =?us-ascii?Q?pIvIeVfjintm9sTx+ngergbv03gEqXmiEmzWJuS+BqBQEr4BaSFllK+UVF9d?=
 =?us-ascii?Q?hRWcKtLApric1cqMKoD84UsUohOlp40Kbdx66fQWxKswfj2BJfZWwK5x2edn?=
 =?us-ascii?Q?kGCW//gwUzhVswlW7VtVMX+MoPvotiUPJPeBOcT9DbJ/Pa2QOR9+FYvU3Jz6?=
 =?us-ascii?Q?gGj9sSW4hpO0YgCX5ELfl6UVtf6U6CuByP3VRP/o1grCgHL7nATm4pKiPBoa?=
 =?us-ascii?Q?JBZSYaulhwJ4NPyKZcVmhQp9BArk/BXLxZUWSN+uxdt4lWhS1Io9lcQ3uIsw?=
 =?us-ascii?Q?1tmkKdV945jrVjhkAiyxKp4SGZyA59xl7z76S/jXIrzU6RrWebH0jrbq083R?=
 =?us-ascii?Q?tWhwsKO8VcNeJmeIqGol22gxQxrvBPbHEcfN8xmFVkNfo/WWMYyfY6ObPgic?=
 =?us-ascii?Q?LzXvZQsN6jm/BKWLg9Mq+OXIBmT3+TkaROjJRKRbErZqAubiTAvMarpbbJ60?=
 =?us-ascii?Q?D4CpQZRnVSHu/d3RylVFkPQs7WaYK/HJyxkPiUsci9AELmO+zdUpo0Xs3wEK?=
 =?us-ascii?Q?PgZi6hxCZqhxvxFQjMDePLsquv9m2+aIa9byZZIl2We4SqwbwcD2dGSDvW1h?=
 =?us-ascii?Q?pcJP9SF1APXUaHQandVxPeWGn4BmeysnSGsuk2QQm5ZbThsPTj2R/tU/67QZ?=
 =?us-ascii?Q?/HBzmYPl8gJGEAYktex2auPlZtV8LVKufTJq0SWQmlqxEDEOOlahB89Rwohv?=
 =?us-ascii?Q?aE7rASgTJdGywiQBRgx4defOpGx7pLGKRfNtzRxRlYd2kT6+tPYKFAsrh1jH?=
 =?us-ascii?Q?/ELL/hui7hxMsQ8kv2PYpoI1PmJ0afRXp23LosZZ6kKpqwH6+Ve/7c35DVwU?=
 =?us-ascii?Q?G+6KgLdalJ5E4ahBPfW5o1a1HeI3eM9yn4m+CChJCbZH/oXcoxModNKjci9z?=
 =?us-ascii?Q?nLl4Ip6mioctjusMowRbF/NCHgSwbwSEkD8h0N02szadRXy0DmgaXcWst1PJ?=
 =?us-ascii?Q?CXXZWv5lYWlic02aJViUkBTJCB7E25Z2fgiGE5qvtvvi1jqpeVPmeiKFfVJC?=
 =?us-ascii?Q?gaYdBXlQnccwgmOoTSNSpkdd3nVIWH3ZWOrZl0O7evo3RiJT5f3TomOk5dF0?=
 =?us-ascii?Q?9njeJpZyvs4dTE3YXUP7Nzvb2P6j8KRDDEAS5uu9mWJVnZ7FNBGPlnh2poQu?=
 =?us-ascii?Q?+uIPvCQf97Jr/vBlGqI9dkAo6WNRqmhYxRL5cspsL0QWHPlaYK8ShWg12un2?=
 =?us-ascii?Q?mq5MV4/KSE+bZjsVCGNDCBjHDj7v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kv8+MJB/q93NWbB7zN59FUlOeSTgSlHmYvvfahv83E41E41wN6oxyEgvxjOu?=
 =?us-ascii?Q?c39XBbJ1jfjyVhm5ym/zVyS/ugCS5dSFjG0ZoNo9uxmCsWKPX8/BfKjJqc0C?=
 =?us-ascii?Q?EYkAtA4gyoFGsiaCW9jvLLW4XDM4P84h9a6EhL9GtHEqPZrfeNW07NWW0s90?=
 =?us-ascii?Q?27zeElx+EQKe/hKq90IVG82wqMyIAVhtalQw0DxMeFuBt8Y7/0pWO/DVXYAn?=
 =?us-ascii?Q?QUSQo1vS0h/1etQiakT+5VOKRBl8U3e+gwTQZlEq061EXRnEYQonwqt+Fh7H?=
 =?us-ascii?Q?RhWAY6kbvrHqK2Yz258dc4+psuq1S16Wt+JFHP1dR/nv2TY2yuxO/A7DR+j3?=
 =?us-ascii?Q?hAt1Qb+RNKoCcaC4gSi/u5vK4SVXc7nHZaaYkFV74oCSsvh4ZkPY3CZwjNHp?=
 =?us-ascii?Q?NM4KpGulXdbeJvOW77MbgGH1U4CJfdqhlDAOmqolVZ9kJHcDuWzhB39Vd5q+?=
 =?us-ascii?Q?c73EVRU40xunQvVPHtTOuvIbGCWqjJQneiwUepH8ST4CezJSEZL8tJcRjlGj?=
 =?us-ascii?Q?p0F8zNMvKxPU0mvAD7BqzP15/pZIz8l4qmAOYWywn8Z8icakURv6PLTne98R?=
 =?us-ascii?Q?RYM0A+zU2WrS1jmaRuMRuM3bMDuFycDLhXk1G/Q4GtcrgrQVBn7XbwCcYxZL?=
 =?us-ascii?Q?SBUkhPfGXgWmitqNDHepQBS6YIvNul5fPZj0RRcYqBA89g/b3HViiwjnCjzs?=
 =?us-ascii?Q?6dmUbdGBHvTLg8zT6R3P8Sbqp5hKXvwmoy4zMXFcvkE5KURBTKkxPzBZtCSp?=
 =?us-ascii?Q?o/6HAK2GgmJ6k83hxV+CnDzzbw8FP/MNUVbhXtq5Z9k92PCFd+0V4jbB0Uzg?=
 =?us-ascii?Q?cQ9RDvVNrtkRkshPe/kpH7hyBqagIYxwLAt74RyGxPjjtOhLGAjav+km9jp4?=
 =?us-ascii?Q?vy7spIw9S3VQQFM5LxF98TrWqPq30rLSginSywD/pPJoXSzxLvVuXE8E1TzZ?=
 =?us-ascii?Q?q4p9103ZLtafeZX/dYFb6Byz+wKMt7XLjG4NMHxh6ksMsVK5I3jBL/FyMkdB?=
 =?us-ascii?Q?zASwPoXc0+pEsXgVpBMxtPd+S0DoFWzUIo5GGwvwCDfkQjkAI6DkyIqfZmzX?=
 =?us-ascii?Q?tiWT6ZdIn4HN7EYrqBmhiFiLsniSlhd80GQfVZ+eWTYwCKgQA58AjAOlHxzB?=
 =?us-ascii?Q?F+o1eArNA6LAsWQB3Wv8m27r+l4qBjoFk8prwDDAHHq4gvTBUrNntpm9m8TW?=
 =?us-ascii?Q?wZ9y2u6roQBQ4ACdRtdMekvg6xjTLrTDHA25X7WjfIHJzudsJulXKoV+ARXJ?=
 =?us-ascii?Q?B1c14Q9LgddEnxs939b2VIyQIO6WlVEe71Jlsx2XSy9TKbLXqeQdbFAAVMxn?=
 =?us-ascii?Q?9gfinuL6vLYLUA4tBeqTmdRyrvBrZ/Idf3Z+nHI9y0aAOlrkGnPWryIFYPP4?=
 =?us-ascii?Q?HjmXa4WuHioa4KUeqbZOp581x5j2E5IPsmHxeXiwX37BWKc6rQoHW3AAdu0j?=
 =?us-ascii?Q?YfuSyTI/6NyHnlkyozU9/wLHHAN/81fvzPqVsatASiz5kVeUUEW4gJ9XYltg?=
 =?us-ascii?Q?wl2/f8zV1GVQteLvIJUHfVMP7KyUxRd9kDr13fmh8nMwCAuamEae/lzJZkdk?=
 =?us-ascii?Q?BojndGK03DdAJ8mHovtjuG2zkubcS3q/iqEG7Cx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f397a61-04ef-4759-c103-08dd3098a616
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:30:33.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+hDZlAoSX6pbBAAdVUIsNlY0LkEFUeksCV/rZ9bJ2EbQrWIJ4XK/cMBy/C2saoDiBIBk3G/mRvAkD1R0+LmuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408

Ming,

On 09.01.25 09:08:32, Li Ming wrote:
> On 1/7/2025 10:09 PM, Robert Richter wrote:

> > +int cxl_endpoint_register(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int rc;
> > +
> > +	rc = cxl_endpoint_initialize(cxled);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return cxl_endpoint_add(cxled);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_register, "CXL");
> 
> Hi Robert,

> cxl_endpoint_initialize(), cxl_endpoint_add(),
> cxl_endpoint_register() feels like some functions related to an
> endpoint, but I think they are for an endpoint decoder enabling,
> maybe rename them to
> cxl_endpoint_decoder_initialize()/add()/register()?

Yes, this handles the endpoint decoder. I noticed that too but kept
the short naming. Will rename it. This aligns then with other existing
cxl_endpoint_decoder_*() functions.

Thanks for review,

-Robert
