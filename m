Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBE25A331;
	Wed, 17 Sep 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097259; cv=fail; b=klV3WsDte/u5qdwaLcDsYNadNu7LnE8vdC870aClcdztvELNw98dBqBiohq4C84l0zXB7bceMBI694QsaFIatYG4YrqyVE8ltOrHgiPNC5IcKlqNdnIztlpOHdwF7LcjfbzcdACw2LXMA9gmEENkG3ongrWjld1oM7qYhlNvNKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097259; c=relaxed/simple;
	bh=YHEgV7ieDnygBIh0+pks2yRvN5x6a9i09KN+98gJ/B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U0gsgwHH7DIg/3CabM7yH9HIPWxrZ7mGxCpz7vjCLsXK9oPxiDLN2eHnFSBY9EB7mRLSogkr/zMJGKQW+OjXdeCCarf/eIdtJ0Q/A3MAvy4xf0PkufROOFZc6AcplpqoZ2hB05FFNnZ+Mnta42rFLamlRpAQ2uhCojeEt2D6ZVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rTlv1ddm; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rTlv1ddm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar7X1F5Ch/og250E+0CQArqTV73RR72IAmFrWxreo40CIm77DEbX6RnddQFfWgMMphKg6LnawgSRZKWBTahIUMxQCC4Nk2+jdIlqCM08OJXqjKb4srOwjjPzH+CahIqi7+IIfCLlxGXoVuTsWGAqur45C01hUw8LNJ3fIgnOBN4VgJE/Fo3cWgBXbrpLGVQWKG/E+x8Vf/M1e23KBpX6ZnCnAwbcoCGc1iwjGa/TrfZ6HCnMSoD3s1TsGg0UhCXmIW2sZ73a9TNZn0GynuA7QBupvwvRrtejfgPrkvhWr8kGEdm+7xc7c8PYAFroBwVS71tRN4zgLxJuF/XOqwrquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e57WTsb/sYNMJGG8iOueJw0sAmzgE72s6sUi9RDIxfk=;
 b=r4Jgg0DyAkKqiYOKcL+kIf9e571+yGMZnFLLfvZ4TLVKZP9cbJrT7eVQtrk3fmuCpieP290I72vArphxMvdST4Sqswr6wFdVtcxEpbYggjlobyezyRw2W8tfLe6W2PxAYSEBhVOFnb/60vSntbhp/6UBx67A8wrUIYomIXAytpSQelNJsUfGmO8/74tdPnZXuMd+SPAzNRrxGvbBNDpCxlbQpQDynblMPwzS1rFv9lt3/KAivnD7jRqr2Sv+FbGW9D2mIGlJdENIJsgk+xOWHYO6tAB2kQs1QMk8wdHFIp+1qaBKxdUAocsxI6+62jq+GZUea79FsH5t4NAL4aBw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e57WTsb/sYNMJGG8iOueJw0sAmzgE72s6sUi9RDIxfk=;
 b=rTlv1ddm3zp9kydJJe84d47MU2w0otxhyz/a3r3AOZzO6CF42l9aQ8C5iJbN2aJs3POqjMM1Yz2v8N7MSsZ02VPNLYdFh+6RGB6t6bG7aprQQ++AUibNifPyW99y++4ZToMprH/1o1bEzmkWXEFJLvYYuSu8W7ask+gL+bpDucI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:20:52 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 08:20:52 +0000
Date: Wed, 17 Sep 2025 10:20:46 +0200
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
Subject: Re: [PATCH v3 07/11] cxl: Introduce callback to translate a
 decoder's HPA to the next parent port
Message-ID: <aMpvXmmbons8PIxA@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-8-rrichter@amd.com>
 <2e4a3ff4-72fc-4a67-90be-f08880d5afae@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4a3ff4-72fc-4a67-90be-f08880d5afae@intel.com>
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb2fcb3-6d14-4e01-a98b-08ddf5c31d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?diH+NKZfOVvZ9NCO3etXgiNzb/wMVoDLTv+aQuREQTm9/IFDFY/10sZds/Xi?=
 =?us-ascii?Q?V9GoC+5HwQeFAjzRB1doiQeDJvmlm8UdcXdsHHkT2TFeq1x6WQGccm5tGJy2?=
 =?us-ascii?Q?BVr2ygXcujoZUClVcREJBmKLxxNkxXHv8Dz5jRqPT1irbDP0Q3wiAmoc1Ne5?=
 =?us-ascii?Q?4eJu51gA75W16mgSIAWT1SqPBXyfQn0TC63s/rh1VAaOdcEQgwLQEVYK6lsd?=
 =?us-ascii?Q?WHedNzKC7WEbJSr8WJ2cgsISl109piak/4gbrT1CgXnbyDt9k74Jlwp4DETi?=
 =?us-ascii?Q?TS+ZXBeioUtAwiDc4IBjq2xMorzW5SWuH0xfr1ldq68LGmqiW0U4+R3fhz2I?=
 =?us-ascii?Q?SxWVIuL/aRKAYN5xu7SnlHPmDx7HVOgqp/hWhwITwjb3i3iOUMT/DAtE/wyI?=
 =?us-ascii?Q?jJE859nWEe91P8nKM4Ujn/4HFe5dFcUiX/Ixl7DrIRXAn5FWYInninFI3Tdy?=
 =?us-ascii?Q?O0SS+LPxjROZ05Hta78HUTEqGUaxUUchC65wanAc/A3u0CIfJ91u4ZYAXpPh?=
 =?us-ascii?Q?yS9teXC+oshSbNIFNXvVduAfdkqDPdcGDmHBlszDRqnK632Vzd+ia95haZDG?=
 =?us-ascii?Q?5PIWIv/kRD4Z8xRcLrF/72wtFwoK0U7cfJwpz78gzCxuNVmmwkPhTJGJb5oL?=
 =?us-ascii?Q?7bN4f/M35ymM11DDPM3+rhIhQsmhbfbKoQL4cv+jmeVOLGcu+CToMualZE34?=
 =?us-ascii?Q?GZDOp3O+GTByx44FAMLLunv7/XFJCAInEHzbdjVHcfWhqt0CwLuet2rrr0kR?=
 =?us-ascii?Q?a1gvMdAowZoWsB+jy++iGCHrXKsfv6WzYrq8w5e5Szu7gFl7diNkgxHnAjz4?=
 =?us-ascii?Q?zdyMc2JYwE3pHl1bbTevl2d7Gf+ttIEze92nM3k/d999aOzuJEHp062VxzNB?=
 =?us-ascii?Q?F1hqWxnMSVLPTVfgsN8pI9dwAMLwmH7Qp09QgEovfqtMroA8b7sES4xiQ4Yf?=
 =?us-ascii?Q?IokKf+GJVdxmDuOoYeFh0rWuj9+xGqwjWtjxt2FG7x+hJCsYhzzrQxrD6Gb7?=
 =?us-ascii?Q?yX6DaHSdbGxFM04UE7lDtxdkUGID6MLZ8FBKjCQqgpmQ/LOBMP4vl9QNrh7d?=
 =?us-ascii?Q?ol+ocx5nNF6zXHPO/Wayp0pl3Y4wXQDTXBcd/MJXHSPk18VJaMAvPBZHwcZt?=
 =?us-ascii?Q?BGK+6KR2Iv0ogEtfQdbWqdPdYvNH/Lv5bQ5Mae4+7zbYGMjJoGn1q9dxROkd?=
 =?us-ascii?Q?8661UVYzNGxoBapi6lyx3L83nWUlwAyxnv688C1RynnU8T0zonQ3TQo7uQmP?=
 =?us-ascii?Q?WE4K2AdnzRmbo233AB5DycAT5QlEfATt7bS5Fy4GmVxjFdhIvBvuhjIG+fP6?=
 =?us-ascii?Q?OUDJFz9G/iM3grnm9WSFOPovJtXX+ANROL/Fz/E+IRa6NryClQQijP37JmDS?=
 =?us-ascii?Q?HZUubyP9DE4q96vSqG0h+dCorTevnNXyWMYGJIJj3PELn65G8JqJOYgO5zt6?=
 =?us-ascii?Q?9mZmg6C1ClE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ojrhu1o4YkqLnJye1S7MQraG2TSuCIbuPJKIuBuMOf9nISD5IEpH2wlMciN/?=
 =?us-ascii?Q?GWJQq8BdFvb3FfR4MwlIsGIeca5h5sYnNhFHYMtaZgIzUCsBLSV2iv3J82oJ?=
 =?us-ascii?Q?wJP/w15edHwfVysUEDiKVV+CcokjvJZXsoJ+bRkbBik3Z5cIz58m9pstIxz/?=
 =?us-ascii?Q?+psu2zMxxo81CEa+cT2B9jfy42Bysqtu+BMqfxK3TORelcXXBAwT20rIQP3D?=
 =?us-ascii?Q?Y14YAdTG/tN4Bycr6kFIEm2fckZqw4C8nvSsCGkrEPmsWS2eDVUXkfvXjxbX?=
 =?us-ascii?Q?ePcYuVcKFPD+hCnn8vBQ9v8Mr/Dwnt4DT+9+edI+Pm2rLcz1Tq8+T5mjXDYu?=
 =?us-ascii?Q?y126a4ZHWr5tNrV65uWFagxTfMRTu0ljlAfNpeHGGkaAX+HfFJiHjTolGKZL?=
 =?us-ascii?Q?dlXp4pGFZQ4ApVEve66zeQBvjRkH0FFNRXe5C+pGxTYw9mGTApL64UJh2lvm?=
 =?us-ascii?Q?S9utD4TZP62NiPO3FSOlxSKLcY7bxRCKBMw5Ivki2cf49LxjkkVWrcH/T1FO?=
 =?us-ascii?Q?UzwEqOQ7xel/duMMG5DSufOLUYqkmm7heIa/T2Pib55CftOH4abDMX0mpeQq?=
 =?us-ascii?Q?CJ59YxSUoAWZVV+GE0OncMPEUihhnLR4sd1J2mYCt3jyOp8eZ769wHey02Ot?=
 =?us-ascii?Q?79RdiIVCtxgDvX6hcpDN+4uddzzzZI7bn4t/g64eoR3OOcNsVVZyDf/r5pJZ?=
 =?us-ascii?Q?3LEp9A3E3w1+9O+0yEs2DLsvcd6gKFbZ3y9d12s3lT89DmIeGKkMMmPE2bjL?=
 =?us-ascii?Q?braaYmK9hutnzouF+D7xIWJVYQ4grxuNBmlB5Z3AiXZx80rpfLTt3AMx7MIw?=
 =?us-ascii?Q?27WL9a83XYp0MytAHmE72KeZq3oY2mkNcSDILvdzYonjwiqT4mYjzZqtaWhA?=
 =?us-ascii?Q?/hn9H3PuQxPnk/yML75Gwa++1ucrwG866VqEDcsNIlFElqQ2GqxRemUdoCM4?=
 =?us-ascii?Q?huxrAb3peodLDlaT8choOt+nseKH0hWom5ow/uucQTAmQ5KF6jU2f3PByAPf?=
 =?us-ascii?Q?HzTSzHHNxBd4wUvvA9F4sqqNr4Tf5bDPGTj4bnRv9HijD7tkqcTZtJ2ncRcK?=
 =?us-ascii?Q?cWmYYEeLTkx7t9lT4nVRNmlkM04qQGTNJMDlcNE70ceBScPfAmTdQdGpiiVH?=
 =?us-ascii?Q?IXzFcc/iYnR96/7Hcdt2kZ07KWexjHuis8rWQ5goitMxN+q5xUNagC5PFkL0?=
 =?us-ascii?Q?c40LFIMZdEJVGMzDRBMpN4wvHErt3TklWIUBe+GsAvqrB+i+KyOx+epr8cUy?=
 =?us-ascii?Q?f3ZZHoxVg0QsLoyl9IPD5OOsemal1wmbC5P+4i611v4YAK+18HmB8jGrAWXT?=
 =?us-ascii?Q?NEq+Ze4p7Non86nT3h77TvoxAsD2HdJ3LqLCdLYbldbwKocTJmE4HS9FNOLH?=
 =?us-ascii?Q?7Wx/eZiJkAkc3oUL60fToPg0pliQrQRgO9DU6FdRy7tlKcLesY5447frTitp?=
 =?us-ascii?Q?T0g+urcNea0GdX2BxzJRqGtffIh0GmI2Qr15bNIf3zvzOjfZ4vP7CFwr+jHg?=
 =?us-ascii?Q?HuXHA8dZv8Sc3FxBZVxJEHXW+BSWpL1Otq6iXYFuUqM3xjpaca4yYJriIfrG?=
 =?us-ascii?Q?I0Y8tX63NZCbZ9XnHESWj1HaYff4J85KhXHzI8+9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb2fcb3-6d14-4e01-a98b-08ddf5c31d94
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:20:52.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ucE+dhnIAkYniRkSdf79VqKzR0LlCFdGVUQHoC1nD0qIcY+uQAr0JWPky/Y8t36zJeEw2BW5zKzVBAkaoUjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

On 15.09.25 13:22:14, Dave Jiang wrote:
> On 9/12/25 7:45 AM, Robert Richter wrote:

> > @@ -619,6 +631,7 @@ struct cxl_port {
> >  	struct cxl_dport *parent_dport;
> >  	struct ida decoder_ida;
> >  	struct cxl_register_map reg_map;
> > +	cxl_to_hpa_fn to_hpa;
> 

> The more I look at this, the more I feel the callback should be part
> of 'struct cxl_rd_ops' and not under each port. While this provides
> flexibility in a general case if there is a need to translate at
> each level, the actual use case in the field today only requires
> translation at the top as far as I can tell. And the translate
> functionality should be part of a decoder and not a port. And in
> this case, the root decoder would suffice.

Ok, I see the tendence to handle this in a more specific use case.  A
change of the implementation should be possible, will change that.

Thanks,

-Robert
