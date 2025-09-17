Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A7306B1E;
	Wed, 17 Sep 2025 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096661; cv=fail; b=fDnuyozd2cjsfx3hnbmYEh2opCtzIk5TjhTbcq6qRJ1qT0a1ejD+UNoDHEDbmJfa2p8XCdkRp6wspjXFMdoLgKonSAlViV/1jzsWuOaYoqm3UiH0nikme/VAiQYWe2qgx/J2nnXo6Yz/u25H8qdvOs8YYlgLa/O1maJsn78dAsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096661; c=relaxed/simple;
	bh=khOs1ab+PBSNDu8iAifXZMeukiLLy53YEvPIKy/OthU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKCL57DH0QRZvb0A5wUbG9ZGGbLvz6mEMQRa+7faHMw+oaHwiXeXPr3Hv+4GMoTrV11q19OMAv4PywXXRq7wjIF8IhqzpBm7QOD+OsyKZ8PJHbUr9ZREN/2uiI75BcMFf7x7lra6vA7WqBErFO+yQD7MkG7ecJduvuYKwm14PS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UkVy1J1I; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UkVy1J1I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVI7fGzPOKJAG1vBvtbglEalA2lpFqnpEpnxteN8F9L0HFtgslKNA/3FdiRio+4QeJp35+sAf8htn3K2LRAIORdigm4n2HwhlPLH7J3S3jZNXZGQ+sNCVpl1MvME+9lkBX3oQaBaE+MLw/rLydojWuNKErURlupqvNyoIChI8BcqE9/qqyf1p6YNWtYdO6Ux/3S337crEIMu1KThkBco4RS51wkv4fli/bLLkaisdmAWrfiBpKUFWxOaBHAhkDOYPoQpYbZ5JDXa+N4vSxmaJ37vQWc7Wkp/CDE89Ngtm1ggANqT7/3Th3U6UApYBG76bOupsA0ws/nRFZw32r/I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awl4zW+g/fIWu1BFclxcXk0tk2HsCnjoPaNbHIV1FAY=;
 b=JXEnuCyOeyY3HoisSxk5MLIlh49OB22ly7nJS486px9nmoOSG2LZm9cWq7akIyBmhm+FSBzSM+5suiPmGBuEDCcxcpPpuCibwGuUBDZ+DDgG4ozpx3bYFcZ/qCPFzXrZ02/Ohpz3c/8dVuxb0U9S5uqtk//DR6ZQ6foPmJ+pb7+dnyfMl4fj/Ea+ezJWwEFy1F3Mnhdd3HUCEUxMlQ2/7VD6juOr9J5RfhbCOgEjZedP3rLoe9GJT62GIfm0F49Jdeg/6O0u6+WPzWcSJhxsHgEssy0i5sIipCJ4HOo5VBNxiLoCsIovlgSoSVA97/bYHAZVE1ajcGsqu0Lp35jM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awl4zW+g/fIWu1BFclxcXk0tk2HsCnjoPaNbHIV1FAY=;
 b=UkVy1J1Ios5SLHtGlFpYEVpuePI0ZZHUNQ0br9BmhTxJVMI4wde0CD30u8CeSsK8+qJXNCte0cJoGZ05WSY3dB5i+TvG0xwyve7CUFrwm4iHGXyr0PtJh5xWxxRb8fOaJ7P9YAcl7GmACospmNkJp9cfI+KHu6rHm9xNju6EmD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:10:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 08:10:56 +0000
Date: Wed, 17 Sep 2025 10:10:50 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name
 @hpa to @range
Message-ID: <aMptCmrATwzBH6kA@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-4-rrichter@amd.com>
 <60f05a02-6a0a-4616-a2f2-d7ae5709d94e@intel.com>
 <aMe_6Olzsx9iYxIO@rric.localdomain>
 <20250915112555.00003854@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915112555.00003854@huawei.com>
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d351456-4656-4e9f-b5dd-08ddf5c1ba53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dvu51rVWqLit964ajSS4Iy/va7CUR1zxiYidxOK3eajEiPZySRkbXGP4Th2H?=
 =?us-ascii?Q?OaAmsNPjbxCyHIvl8g6qgIL33u5QOf46fDxnQrWtnhdLg2IHSGOMY0eUBx/1?=
 =?us-ascii?Q?65IpMTszFhVDWsoN1BpTyISX/2d/8gHZe5t4enm2H2/7RrckT2QlUqPWaqSS?=
 =?us-ascii?Q?WbajVJLnt7W7Or/IxlyEcYesXxsXkZDRayI4cE00n2emTtPPZasJ2UmJ7V6T?=
 =?us-ascii?Q?5PvcW2lTybOpRPRyu79eITn2Vh23Yj2EBcbcVf791E7vONa06uW5cFE2oTyQ?=
 =?us-ascii?Q?HQV1hP3NjoCsRkimlz41clsaaQDVAdw7rtRRsK79fqTwWHaWk6JFEfxIEfYs?=
 =?us-ascii?Q?hVCMspxZ071bc1Th8AWTJ0MDbQzwAvWLZNtnPP1tLavDfEgJWZbJkDs8pR8X?=
 =?us-ascii?Q?yQhkD3P7WD1WMXqO0gk7xERtmRgFUtMmSoG4HOl55Xm4SCUq1j9aM02qHqpf?=
 =?us-ascii?Q?ChxRXFqeCPdp/zbXIwy50sJkotbxn2tqjy6K9mIRcvywo5v7CJieUdv9eqyr?=
 =?us-ascii?Q?kq64O9vARYoh+LkTNUs6LbCGyx0dmhrDbjUFsw3+awnTVosLD82pdARpD2fi?=
 =?us-ascii?Q?NOAcqKm1chEnMj3yM3KBuSCY4iIpwP60DiwDDSwTgYjubTEJbDLMzSrdqe+/?=
 =?us-ascii?Q?QdoXOj3PlvIDox9StyRi25pIMKT6jTvfzwrNXyf7ge/boklMNKkgjLBwpaug?=
 =?us-ascii?Q?kRkX8Gubo6YYFN8j9OlzIY56KNrTqld+CcaPwMuaYeReV8Qo2EI03rlJngWN?=
 =?us-ascii?Q?uIcV+32Lt8zLD+SwYMBUV53UtujDy3DqSSdZYUn6SMm3K8/a1b4H06a7hfDs?=
 =?us-ascii?Q?1DuhK5n9SPEj0X5X5qARLdsj2xA1eW+UNcTqW0JDDX85Ye64YKY6IJOI2gtp?=
 =?us-ascii?Q?LSLLmqtsIMSd96H4Ywuq3pNgGQqwq4aHSjc4j0EggS70irF3rWtskVa+JZGv?=
 =?us-ascii?Q?U2xh1Ys+CiV/ozZSa9cFJwPEA1limimUEq4hvlCjNpCEgDo1GN1v3rhHndry?=
 =?us-ascii?Q?Vd7bkzlWmwR5pcTKT40hTvmanJwlPZxc6xDL0JipcGHt5yag9hniWjCMBIiE?=
 =?us-ascii?Q?4A42HMkmiDLYfDnCiGcSrVGPobFIpLie+bspe0PzPhVf7OAIgpPIVpQpewm1?=
 =?us-ascii?Q?BQBS+V7svTa/2Ho10RPv/hmgkrUlpUoRguHepxKNa+w+tUZfjvDKv9jxqW9c?=
 =?us-ascii?Q?ultDapTpdwhL5mSajJNidvbLPV8jFxh/j6eCwAJlqbBG6jjBP6VMoDZwu6SV?=
 =?us-ascii?Q?53x1UZ6HHJVvVpRdw6btFEElxbYkaWW1mktHI/UZPmEXVmfoFv36hCp5qLzE?=
 =?us-ascii?Q?lR9qS5wX0E2pvxOS6tcDPgbitWzPA/3+7c11hyvs9f2KeU+y8aLA7iZUSJ8c?=
 =?us-ascii?Q?80mAkadTDNcg63Dqr2wxiPqEMEczAewg7WGajhngzW0hEiBHr7efJv9E4JLV?=
 =?us-ascii?Q?LtoQeGqbTAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxPewP0BY8H19NgE9ORYWDMCkQRewQTeR8tA6tkrZ6z5pEkyXyfiojWmurCz?=
 =?us-ascii?Q?apN6groH4M1bqqnRKDKJxZEY4TooMSWlPQuXmMuXTdwCDGpsWAgXZeNYJrLl?=
 =?us-ascii?Q?AKSpPbB/QeYnEgktyjtrsNG/K1S5MTvGlBHrJDeW9jqhUSb050CVZtm7xAAR?=
 =?us-ascii?Q?ZJJXxakB7h6omLKFnXPbnVKbQoXLqXgOFrp9V31/eUyiDAxvAsC2mONMl2bk?=
 =?us-ascii?Q?f78h0a2r3zXfS1rM3mZ5ildnU47r+Fmhfc/rTBwhI2k1UR5h9waK3sL3mU2/?=
 =?us-ascii?Q?1vt/buO7D5jOOdMH5/U0qO7qb9U4O5K2Za+0+uGikxEc9+qCku613wgz1G2W?=
 =?us-ascii?Q?r8K2ZlkWnVV0r6bXSHig6AtFII/+4x2rHAKU7r3A/w29nHXAW+zGc5eS826f?=
 =?us-ascii?Q?fwDaZAjoBujoNcObbacl/8ZOJ+ht8KDol6+4q3yYTl72zWjWVEl/c/9rSp/n?=
 =?us-ascii?Q?ShhHJ0VUawiq9gdIHKhsvn+KrK3BhAyx4WT6bv0jdYTUjn8tGrmDBnpR4lSL?=
 =?us-ascii?Q?7vrM26p/QrzuQCO5hM63PLzeKWQwi1fBCDx1e3QNXuQBMYXes6u6RnaxzWmj?=
 =?us-ascii?Q?yf3EHKjEF5h46QaN9iz+teLKh5tl/nata4O2dnUugedJwEN0PplWBfnaEoRc?=
 =?us-ascii?Q?Wn6HQxEbXQpj4Hvj3eFIDi+NATNwih/BKIAw/tub26T371a83YE+RucCIVkK?=
 =?us-ascii?Q?5wFydfFDkma2Wsy4ZgXu9agIt0Nhr0szy9i7gGt3hy+lv9s44rLchfvC7S1c?=
 =?us-ascii?Q?TrTlx7xpxGFfqoGLbbvfm/oxJnsaFai+RvuUGnxBk6u2rVSnOAvXsf/aHFHy?=
 =?us-ascii?Q?i2tuQl6I9+lTEidP2gPJXm5rjH3KxuezBqYf2juEHie2R+yuS5DYhxFebjLY?=
 =?us-ascii?Q?U4PNJtgFeNAF03bGnrIfCAZ7yFp/DJa/pvxZrr2WDLooc1de6NcC8ljEedOf?=
 =?us-ascii?Q?YNXbE2R39geCD0pGxrjFcG21k4oiD/aDOsuvJoJZGBJRca2hEGJj4ZojrEYP?=
 =?us-ascii?Q?P+QvxNaW11P5VdwqsUeOaShPfLdJxN3jEec3Yw5uWxc2kN7rCMKlafhmVc2C?=
 =?us-ascii?Q?4DpxrmyAX/1yTnhYBVe2N6UPqysj11az27GoMk75ol84RkUCbwVvkBEnQHVE?=
 =?us-ascii?Q?P74rVS9SXXSTxtU0A20bwIL8ijimryXeTiynkGLiQbyxiVBotOK6Ao8bFvHq?=
 =?us-ascii?Q?7/LKlczvXnvxaGf0PfGfSIJVhApVdZC8OlJtb+JgUQ8pTXSLgvyIV2DkLWL5?=
 =?us-ascii?Q?75XxmNiui3x8S0pb1ulfHZaPJ0KasG5k3ha6ckM/Yemg7n33T6ZALQ70Qunv?=
 =?us-ascii?Q?c+SxMXkWbVBgclKpxxumz8ER2NMizMVxsA1kscMI+VFTn8F3Q4zsLZcOpCXs?=
 =?us-ascii?Q?PUu3DK5Z9YyDJUtN4Fim8K5b0qMArHRuPFe+SnrhNk8YribTao5FuIA1AWDV?=
 =?us-ascii?Q?Ig0nyrPNIWkazB3QL2ixxd42i2EyLgqIas0MxDY20g9B7V4LLEgV1YMqo/jz?=
 =?us-ascii?Q?WKp07IiGku+MeoZR+J+auPGP8O679/zN+/xocum5hUiEg5rh9H4Jm5ZHHv4x?=
 =?us-ascii?Q?mS55tjHhQq14bHxR1Lo2sZC5aJPiFjOWuRlg38Z5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d351456-4656-4e9f-b5dd-08ddf5c1ba53
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:10:56.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkMBGfLSJ1jR6Hx+zcAHIZCmUl09q8u29gQ5UY/eXqj0VtO3872r8LNKE8uLdNE0Iz1Wrp3pC2LhqRRXO5auZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

On 15.09.25 11:25:55, Jonathan Cameron wrote:
> On Mon, 15 Sep 2025 09:27:36 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 12.09.25 10:33:30, Dave Jiang wrote:
> > > 
> > > 
> > > On 9/12/25 7:45 AM, Robert Richter wrote:  
> > > > @hpa is actually a @range, rename variables accordingly.  
> > > 
> > > it's a range of HPA right? May as well call it 'hpa_range' to distinguish from 'dpa_range' or 'spa_range'  
> > 
> > To me this is ok as it is locally used only in the functions. I used
> > the short version to not hit the 80 char line limit in some of the
> > statements for readability. Range is most of the time HPA unless for
> > special cases, which use a prefix then. It also becomes clear viewed
> > in context, e.g.
> > 
> > 	 range = &cxld->hpa_range;
> > 
> > Thus, I rather would like to not change that.
> 
> I'm with Dave on this one.  Better to have some slightly long lines
> and avoid any potential confusion.

Ok, thanks.

-Robert
