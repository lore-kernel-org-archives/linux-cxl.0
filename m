Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440601F03CC;
	Tue, 11 Feb 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263426; cv=fail; b=f6b8lqgY1xS9k0dyk/6ljT0JcG92/0wK3o6jvyjiPvnVuLQLFmfDv8pTq6j7AMVf0Vhqh50EE5moaRgloO6rlnV6oACdHjWKxSySz8ya78Vj+Hy/ss0gBuCbk7EYGXcF5VmIX5qJoLLOiJohj0QfprXg6EU+qyTk1S6XQNXR1gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263426; c=relaxed/simple;
	bh=L7fo5YBR5TKYdmhmNxTu0fe1FIHYIyz29rzH8LM1XoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VIQj5cvTocBSWtP5LZ7YOSorqFBj3KamxHkknfu11GeuT0/A2Kf4OYD9LUlLPl/xcU4g3THrvv0yCNDGQCYopPCWr21sk+PIi/CpTN+n4UC7SN+6WW33IMobOaXadIJP0DO3GNtxu8RJU/qXYIjPiERO7ylGwIuTVokXtN08CQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jv3GXQ3l; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jv3GXQ3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5i/y28ZfmwMZYamYRK6HEQP85q6JKN/KlVl2DfGEQ8Jh3vijr2wWKFGjn6krnPghBA3q8pjQobfNWdvNaSd9w5P5aIbsp/3MN1RROYnBRgOYrO4jEFSn4J0d2Vajgktp22CmKK6tf19SLdylx9jr/Hky3JIWNAHJIF0V5DcUkkCqXlOX0IvEgwAl8M8TZLkDYk/kc+Ky6q63a2BO2f63bWxjSK3eXVNVrjHlmcFuWVRmQXaHJhfAy1hZbnnWm/AWtRZ6ACQDG5LjprLRsPAZEJ4Y8e/0pbxoNdttzUgtv5Ob4fP2JT39XF4MsUWrYdE2EtjwxF9R1wl0wAVZbZxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsZDK1z6Re9hjEKQbEpAh6AXExiQAerDN1NxD2ziu0o=;
 b=DBYb6UQ+j/hB3XCFuctohIp25UanTzc7rNm+Y1dfujcN1IEI4c3f5CbznMZQ8kHVKwOOaRhjXIHB38PgaWlwS99xSYgFEvv1ssQYbFiU92LZw37SogxnocIoeH+2aTPVaI2/f872kxAGWEYs+EZDR8ZMkOpHlcZwRVYC+VN+4tSMQjjSI3Jh/sjKpmsCxDQT7IY4ozanD915qk0bkezC2HG5LGZOH7JQX5lzmkiylR6H3IovUM2RgNTLMEAq9Qfh3Sp6dTDQoWr8XKECN6y0CeQsGdPu7Kz+ZY04A2+z8Oeh1yF8dLVm+kwJOEy+hLZixr1PlmpKD3wJE0neUCxBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsZDK1z6Re9hjEKQbEpAh6AXExiQAerDN1NxD2ziu0o=;
 b=Jv3GXQ3lqqH0SppsDqnJOlx9m8Nu/SpjqItspf+ri2sVzhD+gotaj7ax68MLWvA8njoY9Vl1kNYg62ANWFtqTBD3b0faqSZIokd3nHNNx3OK+BsORerTnc3UDgd2uaEYzCMu1BGlell+Zkbi23qBCrdo0oPtl4OFhf+5vE1JxYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:43:42 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:43:42 +0000
Date: Tue, 11 Feb 2025 09:43:37 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 00/18] cxl: Address translation support, part 1:
 Cleanups and refactoring
Message-ID: <Z6sNuc_HuFR3yw3q@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <Z6Z5-UQYSfi7Btlz@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Z5-UQYSfi7Btlz@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 062d9697-e33e-414c-edca-08dd4a783075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D2Gc3jFNths7UQdHKrFNmCvXHfpTiRguxwnQig2RpJaKlaQVyllh4AROcyA?=
 =?us-ascii?Q?+4Mh2Nr5LhDmXMuximHyx3FbIdhaNf3S28TNqAu9vf6SOt2zk/ZaYUHZUNWk?=
 =?us-ascii?Q?+4uAgcbZm3XPGzGA1DescLyGXPUlB8P16GljxAcVxI3vDIDvt386j1pEwoLn?=
 =?us-ascii?Q?3wctjm38zKJjYD8bQWobQw/Sz2RSXrXp4t8I2Wyhh1+qRLqXu+odwEUP7ayG?=
 =?us-ascii?Q?Ti2V9FsYXdFw9ZBs3NIWgS/VmpE2HteinGT9lOY7ni1Z9/4RuTuMa+Z8Kv6n?=
 =?us-ascii?Q?LRDEiddms3mW+mV9E4Lp6HcExxQDTVztBiBk88se25FfVlklWzhZjKbCXZTq?=
 =?us-ascii?Q?30/308F9Mwpks7DcT/tI+GINAZkyuB48XAJnbkNdkC5UPReGjIeWTAmFJ7Ic?=
 =?us-ascii?Q?nQ93j3ByrmqDSwRXfKc66JPfZ1JBNo5D1X04NcL/mVwS5PVMgQv5qJRWdrbk?=
 =?us-ascii?Q?oQAsjncjDORppUjdcsOmd36/ihKYOj98EaGuIOnynhVGCCUOnUk9lOkFYxPM?=
 =?us-ascii?Q?zh3oNz+QeSgzXLDUmebyxTiE+44wmxFlq7ZNuWGf/EwEFCIBiEL0Mj254FkW?=
 =?us-ascii?Q?vGBTEf3iPQ4/ZecabJygT15KRXRYBPbzQEQ/Iphzkl8bz2cHoQR/fnEKlw5f?=
 =?us-ascii?Q?fGe5iSjgjMAexeLFZwOVQS7ysXAew6MRXc5cj4wfEl8mlQOKALT7UdQYJDUw?=
 =?us-ascii?Q?hTtzQnK/hZg6Gp4lDnLt/FSUnlnWPu+G48SpW55pnUHeqhN4ZrbbrdGRSFws?=
 =?us-ascii?Q?rloqoQYE2OEh9+ybooak9Vlq2/EuBrEKl5LO0BZVbJ2XTFSQVi3sbJhnQGR0?=
 =?us-ascii?Q?P6TtoqIEWS1FWLi4Ymv1KwsoPiZw8OcH0yTb6E0epn0H7rfPE+q3QobLXPU8?=
 =?us-ascii?Q?HM3W66vesdpAXYXJ4KPa5sqnyywmuK/hUsW1O5fWe1gUjaMNmyXzSEhwU0S1?=
 =?us-ascii?Q?+/1ljCjb/e3L3a05hRup2HY0oZEMcCItvPUIhS8YDNuEAvPmTeqBhagqUoAl?=
 =?us-ascii?Q?cdN+UvOt6SUbup0iM9lNevgaVxAbRcZdl5TJjWKCDZM4tslVIMRpNjGh8z8I?=
 =?us-ascii?Q?1uqbulluBj9g2BQf0PGJfx8liSnv1Z8sdZ8r5OiAUCoCC8r9pGuFsFfFHhiR?=
 =?us-ascii?Q?JYG0U8kw0RSUuOHr9Oh80c0NXeOkmb+IOuf8uezlarwKexyhmtVUOovX7ouR?=
 =?us-ascii?Q?JMwTAZRtA0ZudEkgIKCgpsV+YzSgpBShgUnxJMnnTEYdkYnFUrqThyFJq7xU?=
 =?us-ascii?Q?gwCTLjgEdH6a29LNkJdF0v/cu63ZtNY6hjJ6s3k9fvMB7TUUxI206+oI2eGW?=
 =?us-ascii?Q?jMpqO9iIVlpfObZu8ztb5cFduu49xa69xuDymoUZgRLiIywNVhMq6dqhWHHN?=
 =?us-ascii?Q?j9baq7s+lSwIsTg8NWfGQVTLIeP1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paOCHk/NNLxPsJD7R0bTinTFWuD9NfaPCR9WX4pIuMnEgfgDjXDqia2yI/zw?=
 =?us-ascii?Q?s/w9ZY/febh0PFAONo2B6lEpZEkKWMoxtALL2b4pGEktYhmXIfH2PGhVxsxB?=
 =?us-ascii?Q?cfszwEkZg3CKqaxHkWkf1H7TjEsyns7XYQmu98WPAmUB+ZYs699qokNAWDQZ?=
 =?us-ascii?Q?7rZfZ0NWX1HzfxOm2cHnoY8pl/vbYxoDaPjY4GC3dZgOb4wkxTATH6pxVBNj?=
 =?us-ascii?Q?42vhCkizQsoyfFRALihzKhkoFFDvkVCjKq5f4APJQdw2FHO3Jbu16czgUi0e?=
 =?us-ascii?Q?Llmz4OAAYdnd+7BDtKTF19x0SqgyX/fh5THwZxsWfdTxp7p+EGjn1U8ScZQs?=
 =?us-ascii?Q?1YdISk0OsskP/BuLwZZPMkpAZhR+QrmIhEfskWJ8RqZeLo3CY4QpIHLosMDd?=
 =?us-ascii?Q?jeiT4f1kIF0u7Mh0DhcIKoMrMRA6qpXnzfNPIkGezqZxsol4iGP9uraE6rne?=
 =?us-ascii?Q?9hXEwOT0WsW5rSKcrUq8fXvPfyQVNg3/YYnI3AMwXYQInv53rOXmd9Qq+sFo?=
 =?us-ascii?Q?UDTDbcrjZDjvGoiVfuIGGhLBbASvr1F7Oxn7QzjtYfkih7GPPrRTWVSXREjz?=
 =?us-ascii?Q?XffVA/oPCUBZBKPZM/yMXn0HOkPrx1Bj44+Hpym8Vn2cDSdnvfUo82bVg8+a?=
 =?us-ascii?Q?4qFIIwgrEuBU/CJVk5k/QX7JAmr+xVhbk9FfRdM79jPPPRqJ3wi/eFVmOnua?=
 =?us-ascii?Q?tda4mLyO0Bttll6/KpFWe8BYXsbr7jmc8xvWllL03owVZktVUi7CE1QjkXqt?=
 =?us-ascii?Q?4x3vqhrcZG2YVxSUUGA6ZB8o2Q07RhZ3zIy+65LkhE7tWOBBoMsW/nvAdNgC?=
 =?us-ascii?Q?T8sp0FW9MVRiGQQ4mzi+ckOI6H211Mhk5bIV/UoXxHEEEyudKlkTjPjagInz?=
 =?us-ascii?Q?v8/U4zkxIVTt39VCu4c3SFnj3/6i3QmEcnjJkguV2XnzqzP7s2MjmWGILb71?=
 =?us-ascii?Q?7tRzwRwtItBwhQylFKFtltcJ3ZWhHwt9ouFQHOrLVuc5n4D85yZwPwiPI878?=
 =?us-ascii?Q?BEzJN9ryZNxnxRrWj+oZvrGKqA1rNpTJ0PoRxkh3haj1f4JZOH3ZAnLe15KQ?=
 =?us-ascii?Q?cHkVyHBRwM0hNnqeI8zfBpO0NU3FfyP83Zu+iJv90CFD+B9rtkviHAJ5+RVU?=
 =?us-ascii?Q?8Hab1UdGqXggwO0tM8cyiFUh7WebBICauvFjArz6oPRwnsCXv5VxhW4D261q?=
 =?us-ascii?Q?J6NRo9xz4cqebCUjXE2m9neCs+v8OkOd2UIt6uZkpg3z1BChHfDS+Ak2w17h?=
 =?us-ascii?Q?iW4Xf/G/XLsZKppEHPNTIrFbHZiF9OydpdlZfuS86NQFRy40dRrG2z7sYZxG?=
 =?us-ascii?Q?QykCJFbj6qJtasoK1ufa36Uojt1wvIsU5scrb2Kmv0whfE4TI7L2UEOfoSDd?=
 =?us-ascii?Q?kdyqwZfeIHSqTKy+8WG/my8toGd636KriC/3YM9+03l8EzxQpbG1+i1gKWfp?=
 =?us-ascii?Q?m8GfnDKKiKAUFGT9ssBAVosUimc3BKJvFBf/e2CgbgPTuDKRu4wA1XWZKbrk?=
 =?us-ascii?Q?UKvsDi7SiFDZgnd787PCVBeoSJ0RaIJrUtu3R4WXgrkJabBw7MDV9JLoGDKl?=
 =?us-ascii?Q?FGFfGi2pZr9Wj7hyBy1KmbbnbJf0ngVGgrKVOQvY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062d9697-e33e-414c-edca-08dd4a783075
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:43:42.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfbGF6y0H7J3PSPOExIP+rDP/u6Oieg/UUN7dykBfxYtbiTzUV9/qWxrz6NpdChIiVtzIZpNdBcDQbulMEenCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

On 07.02.25 16:24:09, Gregory Price wrote:

> For entire series:
> 
> Tested-by: Gregory Price <gourry@gourry.net>
> 
> Tested individually and w/ a rebase of the full translation patch set from
> [1] on a Zen5 platform with PRM and translation.
> 
> Will test again with part-2 as I expect some changes.

Thanks for testing.

-Robert
