Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3A2D3210;
	Tue, 29 Apr 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934206; cv=fail; b=UX+fo5jahWxYzgYKnZl4lUydXeZljWeIbwBeEVUEQ1jBD6ouY6LXkkmvLsC1JZf4v5VQkiPfndavoWDNxFDI3tfVx+kCFJA+VT9oNNccHIa5Uk0W1EV2uuxqHxhPsPFrn2Z4mRU9l9RJttVlgwmCsgbmp780CfR0wJmzSVN8qt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934206; c=relaxed/simple;
	bh=66sYEPr8eQrfX7N+qb9HeZDenB/Isx6N4cnC8S275TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtgGSUZc60Shl7iu23WF/Ot9NLPY7jOe0ZMsDnBzDmuueQQ3C2zqQlvTWAeyPHtXEL5CQ7FmLW5wzth2f39NP2idRoPuht0Eoc2wuGB3tyVjNknLp4DP8vNhdVpA0Qua5HWkN09AO8eU/NlzRxT+o5gJGX0EAJhBsPneCEr2vjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXHdg+ha; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXHdg+ha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ul3nK+6wBVmP/1yAmzGYVpNmITJD2wvpTmyhza7fTAtYBXNQTzpDO8xV0bnQjexMAFd6kuitA2jAw129LC9zqR2A9XMcooKL2v59JSqFVBU6ZluZs9Fp6D2Gfsmun5QCIbd88oKZ/gcAyA0Ju/jV55eoW8bmP0tkM2Fe25r+7MG3gbflB+/w7jltMgePOK7B5NR1HrgZM4aff6xdxttX0nLm7rrO1Nl2mvWrZyUEjE7ghBQUWTRhJmZv6qaEhwSAsB6xYPkahnWIcKUuM/izBldPhsHNpJYa/XjOaDj3Yn+ze2znL8PF3JI0NIbss2Wk/09cDoYNwAzX4QifF/Xphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJj631i3RjdrGkVASVE9jWTvNtXtfjm7sds3j2p/N4s=;
 b=Ql9w8zV+1etGPQlyLowhyzKSy68pqVHsnlc2ZHwwpICJho7azNjccb2NGtX5wUU84jlRvf2eC98TFbo4xR6pUd9/2YjPDN7Rzu4hJKpL1IsB/JrnuqQTrnlsImOLp6R9oHXfnicnwLfL2BLa4D86mekDqTnYgc15vhxwUXDYdFPY/FvzoFPomR0SN2+sD59bvisasfO+hH9wdL5GleAoc6Ok6ddq8yAZqzuID/o9/z24PYWhsyJtGfEiQkoIA41dkxY6PGO5kUiSDt/7QdecNS2qiiiIp5Z1k1zg6SBeL863jFZg6wSQz+KF15D8AQfQ8GDEjK025hDABeQeYSKlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJj631i3RjdrGkVASVE9jWTvNtXtfjm7sds3j2p/N4s=;
 b=cXHdg+haz8z563CfG/tEaCnxchg3+SaU0yxG1E1x3/1OOjgVh3UXcVeFn8DRkYdHG84EG4MXj1EdS13zqbTY+R280xVDrXsA2Q8PFLEStFLhMD/9JvWAf1HBP9k39sMXJPw0Q7LrUs+EP4sDDguoykbVjdNylI6CeYK2R2chNio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 13:43:17 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 13:43:17 +0000
Date: Tue, 29 Apr 2025 15:43:11 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v4 13/14] cxl: Add a dev_dbg() when a decoder was added
 to a port
Message-ID: <aBDXbx6Ah9fUWuJN@rric.localdomain>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-14-rrichter@amd.com>
 <67ca0e4cd6aed_1a772945f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ca0e4cd6aed_1a772945f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: e795491a-6f24-4213-7d4a-08dd8723cbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7R8CxQxrgVIwF2fA/HSYL3s4tCWUkGbu7JjCAE7eT41HBa86+V5xTe/xZkCp?=
 =?us-ascii?Q?GJO2MDChB+xbLbR9vsUWuq7woN6rCC5fWqDuIgyKchzIYPxabctV1qRgmEaY?=
 =?us-ascii?Q?hjydBxJvxa3TWKrfLksLrQXGLDs4wN1CAW+FrG/O+RXkHpgBIVIX9lUwnf6O?=
 =?us-ascii?Q?Vj7h+DSyBE+ZPPhm6ZLM98zDuu2K6Tfr5lxdAAHmfbQH73Lq9IYWdIX2kjRy?=
 =?us-ascii?Q?g2BTwcMP36A95JHY435b+LwmyVClPE/LACUgwNroNJawjOOJyfyiQBeJx7lk?=
 =?us-ascii?Q?qaxcc0J8PXUAHd8uyVBhZFcMbL7VNDuo3pIy2e50NE+AnDAKUAPTBAv0d3Os?=
 =?us-ascii?Q?/bFmu3iaCPf6PNubYhXd839zMWbDVTThDUi57K5tbuvvqsY3FrugntXgxPTS?=
 =?us-ascii?Q?0luym/M9AqVsa9PsWW3CzydnsJIVz7AyhXi1+IwMUOyFHbTe+2n++whjIAbF?=
 =?us-ascii?Q?PyIGeHNOl9agFVIAh1waeGdUeRgIVwcTXsJF5A6djX6arvvQEhO954968LG9?=
 =?us-ascii?Q?kLpa5h/bP38ihsi2WA4GXeBzXGpDL6YA6dk3Xbbrr4Jw8hmHs/I0/QIS329j?=
 =?us-ascii?Q?SP/VfPqU7A1R4X1bdShq4oMhui6KyOIez1AGzei8eptzAKh0KB3jzczSOV+C?=
 =?us-ascii?Q?jo3GbzJhmXMIzYHysDD+0gJ31r0mMIMpM2UF2RefyHrH3nzPAZ/hhA+b6nyT?=
 =?us-ascii?Q?ifVjQhYCSLHSe7MJ9Qne55LJgBGnhbmqPBpMjbA0HYGztVomEV6K26phyjGh?=
 =?us-ascii?Q?utE/atxnHuJL66c+OpryiWLYzTNO0Wk1AwRO/OaY0a8ZKQeJDlia2piYJn7H?=
 =?us-ascii?Q?T3XBlvx7dxlDkixptPvwizEaLA4TPhhfR6IwgnTr3u4BTpHI3Qz3XYYiJnqw?=
 =?us-ascii?Q?B3fQvOlL4Rv8efL9UQlyyB5RKrhiHC3w2KxNM649DdjeZnmS8qVuNl7Y9K0t?=
 =?us-ascii?Q?kaWtzYvGyV8/qZ6AEEGZBae2oVGD4fZtblKmP/2Jay7DboNX7J7afzIBr5Fj?=
 =?us-ascii?Q?hWvEDb/GrISC8OAlKWeSX4/3NUt7X36zBdS0DsYed1T944UvUUW7+8ff+Lvr?=
 =?us-ascii?Q?Ysu/mhmIbdrqdRE6FsgIpeMszIN1EzYWBiPwSYp8cBO2w37P77o8/G35f5im?=
 =?us-ascii?Q?qitAfny35yadETpp38sW5KFOfpQfHKLd+x9OxilPLCBoG7dXVcLJ7ghF2cEU?=
 =?us-ascii?Q?8Bws8UWiUo5BykHp6zz/mbDIwoKzYQvwhzf5zy3l44lNvrpT6WF+5s2nUtJG?=
 =?us-ascii?Q?f68Xl/A7bnCcx0qnHFGBTq18gKGZHWHXuolSAzjEKj1aQHv1jlVX/wIYF995?=
 =?us-ascii?Q?JkwvfLFy/SS13Jv7sjXWggVFr8na10O9PMhIAUTiZAP1slG/+5jyMLFGsdH+?=
 =?us-ascii?Q?cNeMrEp7j5Y02NpNpV+1SRE3VtfU5gfbWZ3mxd65aSt3GN+6Nk9GHyHrP3qd?=
 =?us-ascii?Q?Qu/MT3dfiGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1OdlyHilKZDoTcNjAZdcQuZbtQdLRpQHOFDPaSFdH3gG8iIpxaAC9Pn+POw?=
 =?us-ascii?Q?V+UVG8XJFGlgKq3LhflYDDJ/jOxFSN/pmjbWCOmHTHNbCi1U0mL+BRYCh9U/?=
 =?us-ascii?Q?4u5LG8TbkiIq2avzpGHO+pSViXgjYTQYE78NDk7w2YIr5ltx9XB3clstsd8n?=
 =?us-ascii?Q?oN6iCmaBxB2VmSuUALx/rgdHbK/IiITQ5HusG4+ayQZo8WSXyuw9bBC1HD7U?=
 =?us-ascii?Q?VhTjImqe8PuQKUWirq5NFjRbPomzMFhT+n3MZvwc3JgoqXBokst3YniISqaI?=
 =?us-ascii?Q?rI2HWPCLDVmXVY7RxIV9Qj0CtHZTKlms/9NUD1C6MBAvTRoxWJcIAbDNXFnC?=
 =?us-ascii?Q?Z8/mCMYNfU3NOs0migwT2MqHw2krv3Sd/U3kYiw/7J44u8val03UW8bWHpXr?=
 =?us-ascii?Q?0hl4pv8XP189dixCR4yyL6nnZhlahuvieUtbaB4gu2j6KXdLGB0L0mRfifad?=
 =?us-ascii?Q?KTheQsjMnB+hH7/spBDrAIXEewkX7xZA3bKDRWWEbPxH3+k1rrK8HCaOuD21?=
 =?us-ascii?Q?dOIzjKyjjHqPY6hauN3ZrDM16JumglZMxQLElXaxlT70gwIHtmj97zsBAi32?=
 =?us-ascii?Q?h0g32BkSgGvZjUJXdLyLJuAgN7iVZ2Rv7ZsdWppnd9Km2WA04Mt0HB/WWpbL?=
 =?us-ascii?Q?+rC0pAePB3CRVyhLlxFqfK5PBrZz8kLX+u4dHifJmYIqE9nzjmlv1BcqLuD1?=
 =?us-ascii?Q?UTPrErLtjSRbZAzaD9+A6C1n2algE+6N33YiJJK7o5+KmNw/JuY6UtOasVHX?=
 =?us-ascii?Q?WN1h4NcUiS2CJWDYNoKL4VHTL0iyf2HweKAsrYmXR0gpUnLDfhNo59gf+DWA?=
 =?us-ascii?Q?QzjEYFZl0vJc+9PsLcOJPDYIZUetl4+HOSKDHXLreNerxvB1ptsBrPwTny8i?=
 =?us-ascii?Q?Ljvu3SkGxwhaFKlfOD7viaC6AOmiS2yc3wjJw+UqHRseZzpuj9UjbtpGMfSX?=
 =?us-ascii?Q?PpFejC+IQHBsoTk9NKsUFN0lWZoBu8xkdpDsUXrbtCNbNlbeeK5o2VdrXk55?=
 =?us-ascii?Q?bqF98YHZBrrtU7ruu58SG2BMxBjqlZ73LM/PLMBqDz33vDE/TazhvuBG7aIL?=
 =?us-ascii?Q?nccsUAvnyrbl6/WSKl/apUqBuuANS2SAl7wOh82Qqc688wT3bJO4BEZexaGI?=
 =?us-ascii?Q?PLJRzRqMV1QZ5VZy5ZvDi7y2lIEUbCnlgM9EsYh2PGUOMqASkk1xe7xlG2o2?=
 =?us-ascii?Q?h7+8IUPuVCjTojr8RISU+e07NLvMWwN1lwsSyB5FlXqsOtiYlgk5meIPLVY7?=
 =?us-ascii?Q?eqC9vMz300fe05TP/lJQRIRMW7qvOCnI+OzLeYFC8/gQwlDxVOf8DQbE+j6F?=
 =?us-ascii?Q?gcyQgXCANYpz9zUItLqjl4G+ZP6nSjVClxNWjQD4vtmfAK1n9YM2vVUherJK?=
 =?us-ascii?Q?04PfO3LdyQaPie/ZGPneHCFAOat/WUQSsouiDrZ5AxR2fNjWLIiUKx8MGISh?=
 =?us-ascii?Q?lAzSJjsHpOfkWyvweZXQ68zG2Eu5NXBxxGXQymwb7bteEwFRbYgqKQ7jVYM4?=
 =?us-ascii?Q?6cYvvUQWQbQpZscc9EvgJaOmHVV0s+9NDu7ASha4o3re67UDnVfsT1NkBprG?=
 =?us-ascii?Q?O+vM5ProCNV+gmqPwvfyg9YM4+d/YcOP0Gb4wquJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e795491a-6f24-4213-7d4a-08dd8723cbe8
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:43:17.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aD+1IBndsDy603YfsNS0plJDFeVLGV6+H9pI6/vLb8ta0qoMs37B00EZjzQ6r3qcjWu5M3pBXxFTRciqZ1JkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960

Dan,

thanks for all your reviews.

On 06.03.25 13:06:20, Dan Williams wrote:
> Robert Richter wrote:
> > Improve debugging by adding and unifying messages whenever a decoder
> > was added to a port. It is especially useful to get the decoder
> > mapping of the involved CXL host bridge or PCI device. This avoids a
> > complex lookup of the decoder/port/device mappings in sysfs.
> 
> I am not opposed to this debug statement, but I hope that most use cases
> for associating objects are handled by tooling and we don't need to keep
> extending kernel debug statements for these queries.
> 
> E.g.: show all the decoders and targets of port1
> 
> # cxl list -PT -p 1 -Di

I kept the patch in the v5 series that I sent yesterday.

The issue I am seeing is that in case of failures the devices
including their sysfs entries are not created or bound to a driver.
Tools do not see them then nor there is a hint why there was a
failure.

-Robert
