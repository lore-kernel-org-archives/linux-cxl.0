Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F1A3A8D;
	Tue, 13 May 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170648; cv=fail; b=SGHbkztgkP58vp5nwFfJQTrmTbYuUzc+nW6zddyGt4VJo4Am6c9ktLfJ0bRCNOpL0U/63p0d4YtSKK8QMOfQm1KVK7xWc93cAqdDDlRCQA5UMipIYwmLz++DXwqUrMY8RIyfQpdMDgpzwiFbEuIQ+EfZ/R23NJDdtVPYLVrYta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170648; c=relaxed/simple;
	bh=c06gklfObuXUq09DZNtEg8/vZaMdGlbIWW32xXSzZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APZTW5Sz5sTX2Nf65SETXb5iajflhDLcNPKeHcRuWxaxxnlxUcu/IrEVidDD59ikROYyXGas5Geh8fxhimOHLptsedRDWYrXyY/KhZFolKoF6iDZFmlGBT7aa6GuxfPNRp5/ljX1i8fnWCCWo2AUs3FFJtGhxn3zy4XznU8MX+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kbcgQ8Vo; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kbcgQ8Vo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1Gyj9Pgk6mthFDVP0L138ZfTVI1wr7J5WLKt4xgY5V+6kuqFdmXVYo4pMpowXQKBoVv+O1R3J6uVPjDAJAE3wirGzmMNMurW9C5P8/AU5IyIXVQLwH2uc2mH5Y7gbSsNDygpL7h9B/+vykPV64/Cye4ouNzEVVeDp6s+k2sh6TP4R54O9l14JX/3LykuOjI5bp4WNsyaH9S4IEFwJ9aqyTu1jDTYP0DOi48qRkeKynHDo8vRt/g5DxCyQ93cbnHgPwHBHAb4DPpKjKLw6cz/4+sw23v6jkjfs94zc91rUts7T3IBiVWi22XMRN2YJ6dugs+XT+5mYLWYNoissituQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfGzu2sx6lbwIJifH3E8N9/PytCPajnVLWRGIahiDwk=;
 b=hXV5h4lqmBw+mBLXYo9/gDRKa/IjaAZ+4HCaPSi5Y2CIzl/dr/9U3mDmmXqA+feOzSBtGoGTYrCttzI7JahS7WGd/1aSNFVCk6E3mLJllTsPLlbsH7g8a+lLhy1U9hf30TkNB77oActSMCA5HelPbdIBLLzSqVJKqmENLUYJ5cA9xH5DauV22QUR7Ld0GiC60DuhW2IkyeUpqqR2Xj389TknFAFdVpFKqsaIMxMV5XK5Dj9j7TieMR/Ovn4CMG8bxmMIEz1nQ+BrfIe6+ircRH8AHR56ZjchBKo3SLvTJeuSJylBaj71TTA37ahDMgrgSlO+QLB8YhUd9Jg/s4kuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfGzu2sx6lbwIJifH3E8N9/PytCPajnVLWRGIahiDwk=;
 b=kbcgQ8VoXbQV66uQWjIitVt+58vdvVcyRuBM8kJuhXE4KUPn+FfX6R/JFMz0Uvg+XMuFbxi/g0nfRyjvJC/hhFs0ZP2iLoZiCBqAFpg7M9T4Qpcl8s1FFThsKbDao7YklL8cJWLuDSQLl3eDK6IKjdM48yZ4ooM1dk8vswNOhco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 21:10:42 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 21:10:42 +0000
Date: Tue, 13 May 2025 23:10:36 +0200
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] [HACK] drop zen5_init checks due to segfault
Message-ID: <aCO1TGvrXajf1s4_@rric.localdomain>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-15-rrichter@amd.com>
 <Z_CXwnILDyn3e-v0@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_CXwnILDyn3e-v0@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1611d8bd-7001-4b6a-e141-08dd92629ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDW+i1GkgNM9AwacgiPE5QwJJxErJcJV0ChCdDgNpLWn2VMTNOpgVkweA8/u?=
 =?us-ascii?Q?sZuH5UQkrLuXrmi0ckqQ5OkuzKVCRgDpShNzTYAB8wNGoF2on6Zv+1Dlya4c?=
 =?us-ascii?Q?2BclFjPoPQSfzZ2IwbH686RvX9pd04R8oepCHehEkGVtcSKl6LAczr4ZEqLE?=
 =?us-ascii?Q?qGm9jlmWxsOpyz2PM9LlQZyJ/nWuOhtQ8DDo13DjT4abrNA4Lq6Sfby7Z3/S?=
 =?us-ascii?Q?K2ZEoTDx7ZossmaUzOqWRzlqMISnsNAR0BO/dMB1tNmXDvL9+fqPw7YDWZNd?=
 =?us-ascii?Q?f6NtJIAhTJKuWB4ilW7JoDeu6vOJQkCDesUcRxlkLjN4jkCChehzfnrg1RoB?=
 =?us-ascii?Q?iTTZJVCnj0rMaxpH/z6Mbyh8Oej4BD0bgwF/R0/xE4SOZu/LJ7xPXX7AuIP9?=
 =?us-ascii?Q?8apoB+04Kqd72feET8XKpQF+dkcY2CgVAlpdSuqFy3jPhgWCeuw+Xdu1Vw2e?=
 =?us-ascii?Q?a3A+WXbUuQ1D66ktW3kDQdnWVvcx3S2j/MYLT+YKafhr5KqLhzFm1BSqS4ph?=
 =?us-ascii?Q?yI52R8RqgaO9puXu5OW5MrEO+FWM3PyrnJ7MdcN3Ga4W2YiXqnmE7V9J4wkP?=
 =?us-ascii?Q?KyxLunkvV158WBfHC6Mnz+n1C95cK4SKQzAfQiaHN4F1f40XEpsLgeF910aM?=
 =?us-ascii?Q?Nkp75EO3N2tXw4JDt2euh45/0RbUTXDDh5Kg4AKiqs3WYrcxNkPMelNTbgOl?=
 =?us-ascii?Q?zEnwuYLbB0fNbQUMulq4wTTl0Wo9GVU4NMxNYj6JwQ8qLk6gxphHj5uBwCrT?=
 =?us-ascii?Q?RGURw6UVZLNigNQHpTCvw+NhFVQKRRcAj9LiPyn2uc3tm9H+q7Up543GUDC6?=
 =?us-ascii?Q?i6+jMz/YttMh9XyIAmrhz9YHkyM3V9xT6t3BQMObiDqweptGOEoRTsbNWGDK?=
 =?us-ascii?Q?zZuqAtgZjKU0vNDgREjoJ8bdOCDN/qWF+qw6iY2vcB8tjFs/qyTOcGXYRwbf?=
 =?us-ascii?Q?7GWvsLVU9Cgw2wERWa1DncD2FEpflYl2sndHNmQSe26Vvk1QoA+9gpmAZprL?=
 =?us-ascii?Q?xOOaoD3he/cGp5AeTmCMHaekh+dPaVQDZNs4vbYuGjPWBPnIkWukydBEmsXw?=
 =?us-ascii?Q?QLGEyyFvpFEbsPQTwYv4EocuK1yFDNzVnaKlgVp0v7vTbBBn/RwtN6bUTQJC?=
 =?us-ascii?Q?Gbcs3NwmBG3LR1dcL21AEBsTNU5zR3xkmtDxx7GaXEjFNAFpM82rKRwTuHy2?=
 =?us-ascii?Q?koKv8lqsDdXd9S6vS6awbI5yOMMbMSaE9zJoXbvvxpJOVHNpkL0b0n2mPtQd?=
 =?us-ascii?Q?+iaJ9sZ6YsBulQBFG5ZtqqUhIBguYztCz8Pmh+UUH58W6Os8VzGKHmjr96ID?=
 =?us-ascii?Q?AC2GS/CReD1QmXoPptiYCqc56EfByB5+t0+2ydx3fnXqrXcyT5DwCXBHD7RS?=
 =?us-ascii?Q?eyD5tuzbc5TTuYRfZIw8gLen3MKp9W0EE5xF6OfkvKLfCFx2NMPJapYXRrJh?=
 =?us-ascii?Q?U6+i6Gl8w/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tu1HejVwr7CiSxskn2RQAVSPg0Ca27Kt4jldbLJot/Gs+pQF97eEG5dqMwWZ?=
 =?us-ascii?Q?PnYKQzmLpyWFWF3DZGwS//pdPMpjUX1GPY4MJwGdcowU5fOXx/EpECmDzYB3?=
 =?us-ascii?Q?3mUx9XGqqZqjQU10+WZmculUBkHDUW8UAVkmunpUX/oC1Z3ryJ2lzXsXOGJf?=
 =?us-ascii?Q?FIxDrEU3zm4H/311RKRa7CxBjH5utEfha+mUYoFginC5V78PIqnzqnDmGP+N?=
 =?us-ascii?Q?+qsTnZ+3lsIlvfQeJ0MpUFLISNiyAvof4fhT5cg06JqNO0JvmLK3n3z6M5EW?=
 =?us-ascii?Q?Z85eZaOPrjftBbvGlF2fKf/JcydDBGg9HSxpwhJco/Jl9ILID5fkL6WAa75k?=
 =?us-ascii?Q?9ef2E59tPDamaf2QyWwkFehv5MprtRHuO8JJUs8mGGtzMQrKhRc2JScNIybd?=
 =?us-ascii?Q?v50mCRvln7UYwWu70+W/WSTWcjZzyRGdrSI5y/lBw256FeMNuj9wwqYeanby?=
 =?us-ascii?Q?0YK47pqN7UTb1YnXfqeQRb+mDBQIYE33IoUiDWbVtsMZsvL/synqyJeUdl6I?=
 =?us-ascii?Q?g1vYQObAlINCX2kiBSeeTVxSOWF5N1N0S8VR+quV4vl445akCMf7a7F1b8po?=
 =?us-ascii?Q?V/hmhV1dYZ8blUnto134Zd4jEPj3aUgvhSXDnIhh9s2tkld8w7sPimJBZRax?=
 =?us-ascii?Q?GZ54E0fefy6qrnJ/GnF4Xa2XyeFYfplDmgnO/NwFjqdL3Qmd5rtvd+51WIl5?=
 =?us-ascii?Q?eJQ3aP9mpVsP7rvt3th945Q+KXk+9O4A2AX06ktBfwVhulOe1JNtKG+SyPgC?=
 =?us-ascii?Q?OXGYpPc1c/kxNXOsCpkc3rQgXsUr+u+oJsucrooWjvsOh3/0ysf9QTRh/qVg?=
 =?us-ascii?Q?CA3x9JakbWm8XeQF5O/4DZaELcjRbxxtNn8LyyYn7pEOmP4N1xUIW5Wcy/Zd?=
 =?us-ascii?Q?ukIkMpbkz2Riu9ed78VgJOBfRIwh/4Hh4V65YN/zbTkA3mWSzpXD951DaQSx?=
 =?us-ascii?Q?pXUqj8BOEOK5WoujuAhdU0c9/34Xpu7rPN1nF3RJWj3yyGzQ9IxksrTfHyRr?=
 =?us-ascii?Q?+qGtkhGSukzi7KkMkrQC0B/mtDwGItvBuugWr/G/5B51SW/YrXn+F3n5MKSY?=
 =?us-ascii?Q?Zrkg3+r3mbS+THiO1XSm3W1zpkarFNjOxVSp5MUTlCzu72qAwQ3/0xbsxDng?=
 =?us-ascii?Q?923KMhp0azjZBufTZ/bMZ6hlqmzrDYrZmaKsUxdUAOFmxeYjT4zGMCI3rL+A?=
 =?us-ascii?Q?xynL7wY82FEFZx36gWhXrlZv27cOaF4Y7fN4KA/MsyDHrqH9lbjDq2GOgGhQ?=
 =?us-ascii?Q?1vVs9lHVXozBiZImz/lmz7Y/+ERkQnh8pj4NfvetoEP7/NPX0ssiR0iMilbV?=
 =?us-ascii?Q?Sk7GZQiiHvd8gv+eX3VBwXI61lueGJnt0RMdA6lLlhd9S+VVAeqGLes1t/LP?=
 =?us-ascii?Q?uUVh1gZVvUz4RXndBJwaAJ/Vn2lrWrmpyRBaJ6XAWP22SKw6RPk9qWGE7Wjg?=
 =?us-ascii?Q?6Zd89dnAL+t6Wg8baNiEmbVZHp4MUAIWj/f30DsGKfkA9v+XltAAz3umsb3y?=
 =?us-ascii?Q?LkSLgpRzu3NqFQe9Ka9a237+Rmnu2jDqItUFffTTHG/oIQgGu1akk+7GCccQ?=
 =?us-ascii?Q?zgcK4JYwm31ZQXzybW4GrhmOCv9cHQEJonow0LvW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1611d8bd-7001-4b6a-e141-08dd92629ea3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 21:10:42.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6ARleSAWRRTbKm9+CVwV8GTdliNiIG719saB1BOovX1QewoRgklSaeJr/5/J7HkXPiLw7c2lVi2j7mwum9u6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754

On 04.04.25 22:38:58, Gregory Price wrote:
> Unclear why this is occuring, but a raw call to the PRM at this point
> causes segfaults on my Zen5 system.  Later calls to the prm work just
> fine, and modifying the structure to include pci_dev info still results
> in a segfault.
> 
> Debugging this is not possible on my end since the crash happens deep in
> the ACPI prm code.  Seems maybe the PRM interface isn't ready or something?

There is a subsys_initcall order dependency if driver is builtin:

subsys_initcall(cxl_acpi_init);
subsys_initcall(efisubsys_init);

A fix using subsys_initcall_sync(cxl_acpi_init) solves the issue.

efi_rts_wq workqueue is used by cxl_acpi_init() before its allocation
in efisubsys_init(). I will address that in the next submission.

Thanks for looking into this.

-Robert
