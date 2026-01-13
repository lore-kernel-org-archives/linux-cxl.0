Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0763939BE;
	Tue, 13 Jan 2026 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326324; cv=fail; b=QBakpHfq03q1bdcDdjKpQmPRosZuYDOgIBQtXcX7zkUPMegUsrIK2J7/+DzccSOgTuNYWsUmdmlgbpT2EPH/3NidnvjJMZSnMw0KW4RQ3etItSAUAPTSlh4zROyQ5Ll+YRy49zt6W6u7+l94V4kyypbQK+SufmhDLl366tJPrgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326324; c=relaxed/simple;
	bh=8WR7W25awVx1prv3TqnjdDVEblEbKKG7MscSY9WwPy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gLgKfnm2FKeIF2lp/lthXIomV1Pcu7zjFReC4gtsvFS62kKc+GkeZQ9u4qMrxpBWlG2fnhZBgzRdbhDjP6i1Fuaaa3EkKf9HaYXcNDygDALWcgM2i1xNetwFwpChRYagl1eTEsEJN9GkrMzZP3Own6CWllmnDk7EQHADsg37qz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MLL3Woho; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLL3Woho"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci4VtF/ujXMBVNWIoM8rznckizksPuOzMOATF3znBdyl6/1pQnWMnaOI1vw9JwVKZFjMpHYvtYdrcLdrKGhUHTECYOqz1t7u+aQX4OIOY//EXjJilAxuAsfIjsADKzl/lqjS5m70nBLI2jdxPbyx4J+ZPcQ9uDiJZklX1+xxBZvrNljkFENU0KGjqN97Ltn3K91SzmLOZfeWZEEdrUB/bfZDsvQ/BpoRQhhED+4wucGQx/zSUzAEWArvtsyxI+G9nduFygF8xrVpHx2PqxfySgEAadp7Njp0JTXY/nLqSwvZstM0DZF4qbJIhpL+55+flY3TCeqgHwCAp9NWx6l/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ySeSMMsud6p6MJ+6kIcRzNRem6NKE8CZpu7iS3N3Lc=;
 b=ql4oHeRxApH2lC+E9OUuN4E+cH+GOg256KUYrh2GhzYt7vj6ZJw+2k9gP7Wru2Y1mpbsznJ1uqcuiqohI7qWHyaVCA4ZCaGBlB+Z68l/RYAN+mMX/8cEdanoyc0hnPAVZpZ2+b9ns3AsQFBh9fEnTlfURIR9EceNsLIr8ex6eiKYIXsfTvtotH2dj2pPA6DX+MgbKmVJvSLjRW9IFyHc2sPiqtWXTeA6Zz9LYCBGNTN9qIAKO/TvLFf45CxDg0CmZbwWMRtcKpTAl5YxWpg9w1f9cvWI++UG8g/Qg4ZN2xJk1Nmh9cGKTVWYn0qPMs008EPD/dsnUbGArvIWCTVEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ySeSMMsud6p6MJ+6kIcRzNRem6NKE8CZpu7iS3N3Lc=;
 b=MLL3WohonPsv5McgxxZKNJ4kDdimly9wtSJY07hWa4IviJPXe8V+3lqt2Bvp61JJSkLhdJ7SsDk5jLpSklFA27EjfcLxYADIlXFo2NiE/6z1nBecde6ruSdTHZvRM8S4fsb5kYATAyK0az61afaxCmPX0BjsAQKfsGxUprVMW4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 17:45:18 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 17:45:18 +0000
Date: Tue, 13 Jan 2026 18:45:13 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aWaEqW1vP3EEOvYK@rric.localdomain>
References: <20260107120544.410993-1-rrichter@amd.com>
 <3dbe036d-608d-486a-bc5a-b55b690d8347@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dbe036d-608d-486a-bc5a-b55b690d8347@intel.com>
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bc7b3e-97b8-4abe-8e5f-08de52cb8439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DnjGuLSvkRYCSeSYdiW/D7LR9O6zx/nkzbsNWyS6bVTEiypHeiFQ9olk2+tY?=
 =?us-ascii?Q?1eciuw0WAcF9SEXwqT6lA9lawEI/GYgxK8hiVqoWpJRz/+TBEuPAQNnzdVh1?=
 =?us-ascii?Q?R/2iTz4X1bJL2AVhKew+U1eNH7rgNDkQkTtGAAlSvNAZwbzBWee/BVNY8nyl?=
 =?us-ascii?Q?LkCiaX6pJ8KIcxd6jOQSYoACiiyB67q+gTEIa06UnhWFqYTKy8YlrTQsW0r8?=
 =?us-ascii?Q?XQgZ9we+8Fw2biYio/BglADEPZCdlpqqIRN9MtkH+Bwl7rRAWvrZint+9QuE?=
 =?us-ascii?Q?BrJudJXpzpdUh0S3y0C9yN1IwqW5BSOyJjlKE/XDU8+5XDm6KTPJHjbRsKg5?=
 =?us-ascii?Q?Yn/UoMxx1hOtpSDJm9tAxfUNcPNspIdOE+GdIb3qmIRDImz3IJHHvrI3iLgz?=
 =?us-ascii?Q?jx/hxURLloqu6hMWgTrPe0A2k6lZKHl9N4vp8DWpdxNIBv/SB4xBGRN711vG?=
 =?us-ascii?Q?h1/waMVx6PZomVicC8ozZsJ+HxyOWmhv5++OS8VmEWQZepCEQzdxh3Eqs5C4?=
 =?us-ascii?Q?HKRncAo1ucgMIloPzVvfPcRe5pOZ6CjAU4yQrjktE24hjAMkMgCWDo9Ll2rN?=
 =?us-ascii?Q?pgRnA9UvV6DGHZzpj5eqzsKY2c3QDx+pbqGJnVhcUgBVqwt4CdXGlVA6W9om?=
 =?us-ascii?Q?MQEwAc1MpLnD++cEm0lGdsZ9KFEjqXmVBCPQt1mdSXtfWjqduQEgAg419JtA?=
 =?us-ascii?Q?O2trYkf4iTXAqVQ8YO6G9cJFwBcx/6n4mEewlj3qOz20EGmhAlvmlpnkZG4q?=
 =?us-ascii?Q?Q5mgLPG8wPvRarOJUeqhdbIN16H8zD4Odfq0KzIyzafbLP//8Tto4k/aNzQS?=
 =?us-ascii?Q?3hLnOY+FmpD27wRdKUw7GgIcdIggwMGekuIYXEFrJeH+rVwedZqjFsD44FZI?=
 =?us-ascii?Q?tw9LRCIJBwNl17+c3oDmfV43+3N9wW+BKREsPvWk4UVZTyp+KnxS/1B7nF0F?=
 =?us-ascii?Q?z2ODiwemZ7ufP5V/33LabAiApswIGNKyCsuTTQXcjg1mH2sg6vaGz1GY9ZeR?=
 =?us-ascii?Q?G/PMtHHyMCxhboaFXG9k7jkCEnwU131scB4A1TxtN23siAxj/Y4QI94vBmt/?=
 =?us-ascii?Q?pw/tTi82hIwXAcvlnjN8o4EFPIGzC/fk7PodaObvDVXMD3aovStQtjca4eR9?=
 =?us-ascii?Q?R0aZ93WxsBfGk020zoDptttAUQ03ggYlA6Uj4KAgUcpu1v1zcnvFnbb3n9TM?=
 =?us-ascii?Q?2jpQKokLPWUXXVTlNXKfuMXKF6QtzD6imESVV4w9JhXo1VLSl8qG3QUGBUiX?=
 =?us-ascii?Q?KuB5ahiWZb/CQHkt9ocIteWjfmCNfhChsKtgOSufCXMm9fm/fGAvAhSubvYI?=
 =?us-ascii?Q?pHJ7riXSMu1An0IGLo+aUwTmiCOOmYlBR5GwWvG+Rc9+n0KyfPeKxs8D1v73?=
 =?us-ascii?Q?/psOxoc6gw4PN2bUybO6AtZFsue87EloweIVwpYXhF3hzzrOf3maGIs997dH?=
 =?us-ascii?Q?QQj2UJtjdNE0vJOe18HKWfjqz4OhHK7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4qNr+tA2OMMxVS4PKFOB91sZeRQaGLbdBv32XLPew6EXBJ4WqzrkvC4QXW9?=
 =?us-ascii?Q?IesL4i4eRUSbflBoJX7JWs8ZO3RDWGTJQ/bDU6lb41DabWy0CL8wKlho7z+O?=
 =?us-ascii?Q?7PbtBloGIoMZbK2NXVI5omqG/oHEbbqGDRkCzqzsagqvaHVQkff8wHYPumV0?=
 =?us-ascii?Q?9OMEGpvwjISPAiyG43QC2T1xnHsmLW8VTWCJQaaaFhwL9bRVBsMyS2qhHR26?=
 =?us-ascii?Q?YFeQzvgNbTXKNgBth46braEX0SzYdin+IqxQ8DUNRzF6yKvPlOFLu7sq4Gkk?=
 =?us-ascii?Q?dmDD4eG9XhZ+//sHBlRTykewhYPd/NoIoqQ6xj1/UiK9iZmG7ETfhZVs7CF/?=
 =?us-ascii?Q?A5JZEwaT1d421SsraswvHUMpPnWmhbFxPYoNER6T69FMu1QAmxCIRd0zm0L7?=
 =?us-ascii?Q?T2nsBtqQ8pHgByhoBpcjBerAwYi+QJ3xyZz9qId953qG2I9JyRdtwVF4IbW1?=
 =?us-ascii?Q?F0htxEGH6n+t1WPAZYr1C59jCMm14IxKghfxUccUWEBWrM+V4F4DvB5Ykwfk?=
 =?us-ascii?Q?kIIpvCa+lx+eLrXrfxqnIC67Rbf55ViNv4eEkaTRDQmBc2zGZjlvNinhMe1n?=
 =?us-ascii?Q?xDpRDZ5KeYBvMdi8Nl0IHeE9V1WYETm5dIp5GhS88aSuVCn+hr3fwYkW2xYN?=
 =?us-ascii?Q?/X+mZBl6NuR6LfC1Jp6FGnrJiAfeqFS33VrKFJImHIRJsIHq99DNbUCRStLK?=
 =?us-ascii?Q?6R1+wIClH7y22EFotyT9IFfYnhYYRuDaoWzBsYox2FVqLvm+PN1DJ2uk7rfJ?=
 =?us-ascii?Q?DmW+A6/CUWumCvKz1NEMVc+mtz4ONlQ2tv7z4E4yFZB6Mi6dUwPl/itc3GTK?=
 =?us-ascii?Q?0c+I547iJJyfrT50+PiekBeR9UHDW/FMbI0rgE3ZFpCAoPp3TsCUQZRN61bJ?=
 =?us-ascii?Q?e4oUMu6oY+qpt2glrGpickbkEGKN3Hj8RccrWfYFB26GC8/3V6RWYn//Ixo7?=
 =?us-ascii?Q?L+QepzRhnRRsRbHLQLBfk4sIWkWMSH6HWiEdYcDGBO8eK+FeRqfwxo13RyAW?=
 =?us-ascii?Q?t7tRuf4hEryWSUnfQk7+rChlQq9sTxKhUpAYBza5lQ5ITlRt8+0QBr0YP68k?=
 =?us-ascii?Q?6iqHWKRHqidWFokTq/WzocxVPcx5TpoJOGKiA3FQnnsb81Ao4+DYlUl7KzF4?=
 =?us-ascii?Q?f30033y9Y+rJZR6tSTenaLZT90LjZLM0LqsN1pqiHmyDhgS4VCbHFybAoK2o?=
 =?us-ascii?Q?aUPWQ/8IcczTOSCnrn+8bYKKgp6ayAl6iASakkXJiKXGq/WYLvZLgQVZxaCC?=
 =?us-ascii?Q?gx34m0eTQbBshxZnrEwbaMKwVnjKihAPwOafk/I6jJAv1kmWqpULmVzuGShp?=
 =?us-ascii?Q?QexeBwnPQZWY1aiqn6NrjokjZFP50KmLdJYS+ZMl0Dt+SfDmkxX41eN8tQMJ?=
 =?us-ascii?Q?3J755dyK2adCKU7rga7sOoELfANwNF5sTxRQO3wSw8SG/1G/xJFKIC6wmvIa?=
 =?us-ascii?Q?78cZVDK0T2opkZxQ03YgZRWat/NKfvzkwFZRobx7yEcCTvOJgEXOOp+6/1F7?=
 =?us-ascii?Q?QAUmSzo5BKyVguPXbK+NxAmcc0MLXUwICKFlsQvZWaHrdW44NNYraxipvBsc?=
 =?us-ascii?Q?ec24tdOscDugaOnAjE+f8OOkDeexD4UKeNe7242vihuR+wQV5i3N7RRcRbu4?=
 =?us-ascii?Q?oQhk71tu1HllYf/a+9CzysFgsHbY9QPGXksoydEGx0GgDKhFAWBjot6bA8g3?=
 =?us-ascii?Q?v8yCNGsw+yQdg8WTwJ1yU2s4rvjJ+jd6nFRtLXAc2Ar9oAWx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bc7b3e-97b8-4abe-8e5f-08de52cb8439
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 17:45:18.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h54obSthHPCgai1DbSeXypZ8yRU08FB5R0N39y8TSPOzVwQi9cR38gsrrXIa8m53Gz/9uHzuI+1cLJlImgBBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

On 13.01.26 08:51:15, Dave Jiang wrote:
> 
> 
> On 1/7/26 5:05 AM, Robert Richter wrote:
> > Translation functions may return an invalid address in case of errors.
> > If the address is not checked the further use of the invalid value
> > will cause an address corruption.
> > 
> > Consistently check for a valid address returned by translation
> > functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> > type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> > or ULLONG_MAX is used to indicate an address error.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> > v3:
> >  * updated sob-chain,
> >  * changed error handling flow in test/cxl_translate.c (Alison),
> > 
> > v2:
> >  * separated from this patch series (Alison):
> >    [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> >  * improved error handling logic and early return on error in
> >    region_offset_to_dpa_result() (Dave),
> >  * use RESOURCE_SIZE_MAX to indicate an invalid address for
> >    resource_size_t types (Alison, kernel test robot),
> >  * improved patch description (Alison),
> >  * added line wrap for code >80 chars.
> > ---
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Applied to cxl/fixes
> 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c

Thanks Alison and Dave.

> Added user impact statement and fixed up tab formatting reported by checkpatch.

> > +		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> > +			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);

Note that my checkpatch does not trigger a tab issue here. How did you
test that?

Thanks,

-Robert
