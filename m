Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E602D5C7A;
	Mon, 15 Sep 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925739; cv=fail; b=eyTGv/KdXtK9NFasW3+svln8K56NFnqzQG3HE3zqMYX3qrrJpkAohvvpooYpd+N00sZkKWFvfddIlo4I82WqJ/KW/40TSxZ1dvk167ivzztqf38eurZvc0mkNbpf7TZmoFaRw+OSRNT+OeKy0RCoKxCC0VvKsNEK3jo6HSEwqks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925739; c=relaxed/simple;
	bh=iAqRt3bFGPLwUML10oVwdfna6Ev0wSFI0NhF5bB6Aeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ihzv3lIOXIcswA/7sBw/QFyHHd2GclJbUmipHxpMWpI6hIu4/050Gd4vqZPQKQtiziWC9iqFtrm2NxxwIgsQnrHXggdystF+6cEb5rcsI+JVWXXTVDV1YbNoTzNEwlA0liBKpiujuLwvvXNtlU1ZHzRl6OvNfLWq+x2HbzrP834=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T8UFQXyt; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T8UFQXyt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJ7RdEYGdTi9X8RHluhfTDkpuebEzC3xA+6URiZspzPbV7Jt2/ZWHGZS0QXFHj7pVGD/biPSMVhcSiBcgMIdtWnYF4NYtceLPJoSINTlCESEpi3EWyFjY7fVBTUR4yHGIav1uclWL3T7Nsha546FEFXPmN/URMax83W2YJwQGy3uAcwtUCCzDmkf/ngjRA90sk+NQkDguMZH7U/GzNVlK9HCItcIBWEIZIjUnZFF96AOEtSUcG6DZACEEYOJHSyEr7mBhwaR2nNZ16u56WM9ZYZnvmWLTZEWGoPHNaM9HCjNq9BX6s6HCcDnuKb96BB1oby54eK14XouEtd0j6bXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwvg3uCPZd1GohOywuOE8DhOXrHebkVhpWQKYVEZvp0=;
 b=pbUffGo53SobIL+Szs7dmIbbQuikanH2l4ZttKdiz5qDkyfXpxqTM+fPUFj0jBxftm09iWZW+Mr+BITYEOBzePTDSEdtkxIT3g8HEgAmQpGzgSD19eD2AuVNI2gqlnOnIproX1N/3UhXX560kbhma1OGMZ4Ua7i2ly5BDSta2T+i3MKZ0gLizBPJ5RSIiwdYKeG4qjz+IjeuJcX6z1KLtSVxzJ2xXEmdaMacmC0GNs8It9Cok6MSVc8R+o6dxTL4Q7vk17wnkyQQepk8KTXX5is0+hLwX7ReGR3lCM1/KC/QhVHH8JDPYnBEP0HWM6J21hciKunr7Nk1QmW/n/raCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wwvg3uCPZd1GohOywuOE8DhOXrHebkVhpWQKYVEZvp0=;
 b=T8UFQXytlhMOe9SUTMTExszeElyIVtAhDeZ6Nuux78H7UjvWz3skxee+QMAnbFGQdME30ssUevB6f+mIoHTBrPpj8OVBltxoh/wkrxq7nQCGDPGbUj0zHmNSL5pDmIyXkF8/vnJBTtlcy4QOQv84VQeGJGOPDWkVuqHJPSTnAe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 08:42:14 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 08:42:14 +0000
Date: Mon, 15 Sep 2025 10:42:09 +0200
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
Subject: Re: [PATCH v3 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aMfRYdsWJlvrB_sf@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <792caf42-ccc7-4ef5-963b-7c0f9ec765d6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792caf42-ccc7-4ef5-963b-7c0f9ec765d6@intel.com>
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cef91bf-b969-4bfb-7390-08ddf433c517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sjk1Dg6IW3t59IrqYBXCCY2Xmwrm3maLK6gLmhqGjbapXFEGQsrkoEOYy2B?=
 =?us-ascii?Q?7K1gghmKEtX2lvmW6j93xzgLQnmY3BtTzFSbgXl9cFFvd6jqESGFeKxDqiHI?=
 =?us-ascii?Q?F1IsSj5kMyl8FZVFKXBHJQ0o/6MjyQLqiZd+8sqx20UspQtn7OVQJ1MIOEaG?=
 =?us-ascii?Q?sBDz1FrDTyu/9FtP+3w+zFpOmG/j5GB/i5++o0flPc/bu+GkfbWeN7twTkot?=
 =?us-ascii?Q?t7FCE4kEwofvJbUkuLvL8EFGDvjxMnzcUop6RZRyrU2U0OtYMOVEHpV68B49?=
 =?us-ascii?Q?Eu356qS7bFfAPReRkC0HZU4EQthpFbyc48wfs9+c9YsmhZAWyqCWpiWBJK4n?=
 =?us-ascii?Q?6WJFIoK1XTLNUl1iHWYyZjqcCoV2HtPHOWFSOIsShacfsggIV5iG+jC3lGb5?=
 =?us-ascii?Q?l5bYrMUxSTPq8JKFp0OnXNV3hlId++elBIS2GrBB84yF+HxBOBxlbDLOZp3a?=
 =?us-ascii?Q?FijMifQxpmzk0jn36Y1olswdPMYNJ6nOtZpIjfnxK8DlB3Z+kYmHAl0txXxn?=
 =?us-ascii?Q?3mPSO2DNJ3B17Y1R+SWavvEAdfQJNkpdGRYubbO9Lr84Rk4yVBWGH1/9kSsQ?=
 =?us-ascii?Q?2kPS85UApHW7alJ6tcirOg/IJIrNMO0l+L6hE6QjyXF19UqTkUFc8T3SgUxt?=
 =?us-ascii?Q?2RMOBHfOZcHjvPWRSo6otWczDPiTaMptRMWNbhW3G70RPD2+xOH3vVZ1DQ4A?=
 =?us-ascii?Q?Y9Dquu54LyadKi/YxzJpFdH8eiHVtJ5JN0/iq1bEnTolOhh5IW9FdPb4SJVL?=
 =?us-ascii?Q?7tEXbxP7R8gTZlyrAZDjMTvp0nkg4kk/rQrymvd4Tsfkzt2iIo18MkFWEUib?=
 =?us-ascii?Q?z887l1uZT2DzNWD7aOp6vjXUypvDof3ij6dL3hSMluaWgkGGjJDAy2MfnFSh?=
 =?us-ascii?Q?8Gfdva5QhvVuV7GDePIr0qv6CHcD1hWJDqB6SOs6v9tQpDEy4OosHozT+dzz?=
 =?us-ascii?Q?uJJFrY8s/helqRB+9URc+UqH+Uka04dHEEJa3+fa0E1RTUwh7hczYBrC9/N5?=
 =?us-ascii?Q?klVtsUuINbKLLvMFOXil3eCMqg35rD4OfbdJkiJaQsds6aFoTcDG+RG29PiU?=
 =?us-ascii?Q?tziJiVMTjGWmoBfc8SVw+vKpa+OcEGld6X2phi7CdeRnEoF5Aqbw4TzfmZ+3?=
 =?us-ascii?Q?n/AE+tZ50RHrKF2ahN3ws3YrD+txxth8qak/I1GdZ7zcbo5dX0sjgQCZiwUS?=
 =?us-ascii?Q?p1vcc0U6OHptp8jjCLNYpNkk/qDW8dv2Um0Zptyq+xtrIjZ6E6SG3oBpWbqm?=
 =?us-ascii?Q?m41uGOWpL2EsIq6eNMLEJ+rPpSu8N+Nvrs36ZS/scIev3RnkUfFpQBSF6BQT?=
 =?us-ascii?Q?OUNNj0Trkt1MfqA5w2SHoDZUOIfpojAzZ87l5kJn6u071PSoZH8ZyyGEwJ36?=
 =?us-ascii?Q?rNTSzIiItZC6tIYQy3uK4y34KgmN0BqYIlauDVCVjPJjunPR49pEcYIu6Kbb?=
 =?us-ascii?Q?Evjb/yMdS4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fitekce5CawJ0vG8nVFSFaLlWkEhCgIRyeLGjhM2CR6qGHPEryTUzigYyX3n?=
 =?us-ascii?Q?llMfq+PlZGoKU2g3SSZs6fD/7J9FFreQzIFLnIzk4QtX4x7ykxCn/8zpV/mA?=
 =?us-ascii?Q?ocPigk2lbZ2HbgBZe1HkaOmtLaxOyZr2SIao8FQnvZ/+Q1Vmoh4USNKJWSGT?=
 =?us-ascii?Q?m5R8UiVJtItRIwdZ4yT8aQdO3rMISloDa95WSxerndNat9u7AEN8fbxh11fH?=
 =?us-ascii?Q?gUYkj9DocjnorKDKfRmQW/C5xmbdbIbks1n5G3tujDe/fLlhwPvm0SzNFOCY?=
 =?us-ascii?Q?ybRfIXGckhh1ZrHJK64Z8tB73FhSyVNTMbrsyitsJ+9NbkyxUTChUu9lVxNH?=
 =?us-ascii?Q?cYksqLd/x/fJkE6O3ndopeNpnUCo/xSeP3C2CPOVQDXgG8/MYIxsqpH5YzVY?=
 =?us-ascii?Q?liz4wLD+Q8Q1PMmDEKcTSdRAs+IgC4F3cITRSUJNreen87X2DGTYkTpX0hfe?=
 =?us-ascii?Q?ZWKOt0ZjUoFoW/q94KNvezO9b0fVBjK/RDFeGAPGb15CoMaeKjHf0kJKyzHA?=
 =?us-ascii?Q?Zb+6XIkmumT47gqxB+2o2D3gUoaNxd68WqnnCs2zxmwKymdz+oPMWUfnuhoq?=
 =?us-ascii?Q?kWXN4xa7gMSTLbCjVxLEAWPsh5Wr785uisOZ0Sh7QHRZOgtP/bhC+GQNifTl?=
 =?us-ascii?Q?INJrs/bFRCOHnJMvSaTin2EmPBRvZL12CK66A2T9s9k9eKsvpAiR/9AOZ1bw?=
 =?us-ascii?Q?SRRlIhF4KFbhg+3mzTRnoLkKUD1IuJhs8HPq9iLRwJRd5S9MGRCBOhCJ/Qa2?=
 =?us-ascii?Q?YKYjJF/vWBf709/ZVxG+VvG1QL+SBdUuZF5w+teBZtgOzNrETZQ6VTCPelWU?=
 =?us-ascii?Q?SFIgPTbab2LpV553Xdj4BS8uria3OKon1S7jouxOzEZZ/NjQF7lpSgt53xQd?=
 =?us-ascii?Q?EFX08Fz0XHISIlwuIY5n/mKdFxaXgZA93VCCAfNWINTxM0AgAF7AXq/pzxP1?=
 =?us-ascii?Q?gNEz0T1R6JI7L3aF9Vh1n0uIcZdgXYnJJmX5xijc+YwnjozEjvSGP0jLUqJ7?=
 =?us-ascii?Q?64ZGKp+HahRLNvKBkULhB6hwdvU71ktsVbt5VHiUtvKlIA4V1d1hmliNk7s9?=
 =?us-ascii?Q?gDNvvkreDBnMWHqAEesLHibP+WNkL9P7N02psNZqIc+GZjM+rV1WLCnGEisf?=
 =?us-ascii?Q?ttsqLohMvoxgNI4hzXzsX9Ye9+r0mZ0sUHoSs1q1y4pr+oL0H/PRHB2/Rtb5?=
 =?us-ascii?Q?hIOSsHm3ghtBBxK1JjNUYfKfaj8k4cTN8BFigR+SO6q8d8g+KuuNeIAXhuU3?=
 =?us-ascii?Q?zVKbm7F5owkOXjqYxezmFK+b4/NEF3TeHGuNaueAbAxOdMy0lNHAOot4kZbt?=
 =?us-ascii?Q?KhPPTw4Dmu6PaPQLGFS+dyPJwpBOuDVlENCVb6xwzvXuzyILs9yGvxK7kne0?=
 =?us-ascii?Q?3POqpm0UGvNPeDwleQ+d4AiUG0ljmyJhq+Hz+oeeqAXr57wGj3pesySd/a2F?=
 =?us-ascii?Q?qbH8wM1u91iNAP+uth/hqZcQzPv86SXBjZ/pTINO9e9m4xgWRnajaL/v04Fq?=
 =?us-ascii?Q?ed5Hp4kAg8wMsHnyNco1TfNh9YP4MlvtwieFrPYgETro1Nh2Psxkm+8B4SPv?=
 =?us-ascii?Q?I8V3hGcJtwRmeRh34pJDJQJC3U+m/Yhpuu4unCgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef91bf-b969-4bfb-7390-08ddf433c517
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:42:14.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8weQCofG0XdLUOoV4bZedOO+8biR8O8FAAglMPnCiVtOA7i+eDRKFGTU8X9gloRvkO/bGlbSHKNqpOpadDu8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

On 12.09.25 08:45:37, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > This patch set adds support for address translation using ACPI PRM and
> > enables this for AMD Zen5 platforms. This is another new appoach in
> > response to earlier attempts to implement CXL address translation:
> > 
> >  * v1: [1] and the comments on it, esp. Dan's [2],
> >  * v2: [3] and comments on [4], esp. Dave's [5]
> > 
> > This version 3 addresses the requests to reduce the number of patches
> > to a minimum and also to remove platform specific implementations
> > allowing the Documentation of CXL Address Translation Support in the
> > Kernel's "Compute Express Link: Linux Conventions" document and an
> > update of the CXL specification in the longterm. This patch submission
> > will be the base for a documention patch that describes CXL Address
> > Translation support accordingly. The documentation patch will be sent
> > in the very next step.
> > 
> > The CXL driver currently does not implement address translation which
> > assumes the host physical addresses (HPA) and system physical
> > addresses (SPA) are equal.
> > 
> > Systems with different HPA and SPA addresses need address translation.
> > If this is the case, the hardware addresses esp. used in the HDM
> > decoder configurations are different to the system's or parent port
> > address ranges. E.g. AMD Zen5 systems may be configured to use
> > 'Normalized addresses'. Then, CXL endpoints have their own physical
> > address base which is not the same as the SPA used by the CXL host
> > bridge. Thus, addresses need to be translated from the endpoint's to
> > its CXL host bridge's address range.
> > 
> > To enable address translation, the endpoint's HPA range must be
> > translated to the CXL host bridge's address range. A callback is
> > introduced to translate a decoder's HPA to the next parent port's
> > address range. This allows the enablement of address translation for
> > individual ports as needed. The callback is then used to determine the
> > region parameters which includes the SPA translated address range of
> > the endpoint decoder and the interleaving configuration. This is
> > stored in struct cxl_region which allows an endpoint decoder to
> > determine that parameters based on its assigned region.
> > 
> > Note that only auto-discovery of decoders is supported. Thus, decoders
> > are locked and cannot be configured manually.
> 
> Hi Robert, thanks for reworking this.
> 

> What happens with the manual configured path if only auto-discovery
> is supported? Things don't work? It works with no translation
> needed? Platform will lock all decoders and not allow manual
> configuration for CXL devices?

Endpoints, root ports and bridges are always pre-configured by
firmware in this case. A manual setup is not supported. That is why
the endpoints are locked to prevent the kernel from reconfiguring the
decoders, see:

 [PATCH v3 09/11] cxl/region: Lock decoders that need address translation

-Robert

