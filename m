Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41438F646;
	Thu, 12 Mar 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333362; cv=fail; b=lj0qGj99ZNOYj9rcB+VJzWJstbVPAZlSynjKg2P/WuLYM/1EqMjSGfouqVkWk3H2fk2G2IEIzr1NHxgCS1zfGpQdMSSEMRLBDfe5LWpSNdtx1LjZ3lSAksCZsEiOchpWG7Nzqxukn7jvqQ3gIqnqiJHTto3BVqxfvHLrzo+2yAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333362; c=relaxed/simple;
	bh=LaOwOCLTECmm7nYpPAV9cCXPWZebHzrJ0tH+OK+UmPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoGVRXK2VZBc8uQgbI3mJxIMhKZ0HX5/Jby/x7d6llukkWcCX34RGT3qUZq422SgxiwlxESgxHF0Z5PRDyPHRmigsrLPmV7zaxsqIdzznAUe94E6o6wehU/y5EHhhfludAylRrB5jL7JIgZ+yelnfGVyD+NdBw8olfsfLyAx/VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TBhlXb3Q; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBhlXb3Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnANdW8cphLjzsjBAuwBpZ1e3BG+0XPCQURWmqeDxF3sV0RmXVGh6Q19oxUftZc5ofCeGZb2E5ZVra47fZvxpS5S7sEluNOw0nObduoNfJt1K6qwaYfBTRvoIXwQ0/s6aMlitI8ss/iIW4LVdATRsrt3ywKSHw13wySsxahcuNENN4eJ5cPtrSZeq9wkKxdleS6qWXoYmbk7Jt0KdTduz/EA/3QpT8PCYz1NVf5NqiNTsegm1Eh8Nr2x278J9TnqiHvZzaYwsik+UbEoyNC90DTOwsqf8dRXegqNmYFARaT/G9B7hfLVIn1bfFHF5H2re94GFaymDjtig4GHwwaU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GBisDdBjkBu+BB41D7htWCTz7AnwBZcPo+p5734OJ4=;
 b=Pzj06AmhI/tJGDTo0Jnw03dq/Jtm3u5N5c7URSjr4pbGYC9gTLDwz3mA3DnccsrQG9AurdBjoPHFGUs8LZeg9Qf4pyzFBWvwV8bEOKI5f87PJAsi5GCkPMpGXZ+DSrqhhelgklpYxBzqqKBMJL6F41r4HdOt3rUyGO6ainXt2N4UvUj4xjvC8NUwWqFb1kd6dQDTQi0fBHZUOT7jU9qnVmTTYnhVONSLkqmYRtViBbAYwf9MxzK8s8ryWcQs3Eo9oLLeIMxMhZmoZB9wT6JIx4jfPx6riXCmNrtWHfm0P4/OiOWTwFi3vFlCuakNpO8oYlwSQ8reMIACXCIfu2W5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GBisDdBjkBu+BB41D7htWCTz7AnwBZcPo+p5734OJ4=;
 b=TBhlXb3QwRASlkBbLt+LAQpqSAN3ssTjsEJsil7V/KMSe5KXwPQjPMRO1tT1vBSk3Rcgyzl1/1u51Y4i7DrMfTN2f6ANZRRyNn7T1i8++Ks8fp91oPus+8pr+moRwJRsI/BBriS3bL7A1sleEPfz7BsXAua/OiyTLwl01lK1xeUfKgi6k9FYZLCnocCid+IhQiQVIQQVjxjC/MxW64DvWh+wsku3pEBSPERmCxK7AuFXtpD7bnzuOJN0HTku6OMGXGgkUvkSX4iDBqmBLhuMHlSFz1cedtlpQlAkDsgiMQdHkY9uZ7jHvl0YwG6mWCKEIRPazh4j7TfuEzdJTFTb2Q==
Received: from SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 12 Mar
 2026 16:35:55 +0000
Received: from SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b]) by SA3PR12MB9131.namprd12.prod.outlook.com
 ([fe80::7afc:62d4:c53e:1f1b%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 16:35:55 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Gregory Price <gourry@gourry.net>, kernel test robot <lkp@intel.com>
CC: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with smaller
 granularities for lower levels
Thread-Topic: [PATCH] cxl/region: Support multi-level interleaving with
 smaller granularities for lower levels
Thread-Index: AQHcR/C8ZVw1S+3zKECQ3BfZoY/gGLTb2PMAgABvmgCAz6N3ew==
Date: Thu, 12 Mar 2026 16:35:55 +0000
Message-ID:
 <SA3PR12MB913188B8A022C08F3B949F78BB44A@SA3PR12MB9131.namprd12.prod.outlook.com>
References: <20251028094754.72816-1-rrichter@amd.com>
 <202510311413.HdTizWHK-lkp@intel.com>
 <aQS8zJ4p-r5iSgd1@gourry-fedora-PF4VCD3F>
In-Reply-To: <aQS8zJ4p-r5iSgd1@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB9131:EE_|MW3PR12MB4410:EE_
x-ms-office365-filtering-correlation-id: 533fca71-5e34-4c4e-823f-08de80556ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 sk7GhwXJEc3Y7z8gj+mT6DPHIMCmNYgoay96/rGyVURGEL3WkKsbtN/LPfW52fG8VyGtpgockcnzYqRyq0DrT6FXcsAeKaY0B2aPW/Os/S6VrBAt1O2rFJlHi4WYpIRv3dBLT4hLiKRH3Nr+OUiCh2Z7NoQxDD9i/9866zaqr+1OIf5Eu9+cL6/EpYg/X6xPnkK2k0ObdDMqgdKBMdS65Hnjq304f1GM4xpWZJkairAkv+jBIrde/zoj3ya5MIzFRUvg9REUkezXkKuu5TZROlhYS6XwGVO06mCIO0sGgf6MRZ1VifMq4hay/dhDkjdrnjriUW94o8nuvLFHGIf09t4w8sMmzHwhi6G+0fodWvXiFCaG3Dywqd4HvSidpVSTJYWGEgcprY/3+c3rbSTqdrwmZD1fsHFWYt0EDDUUSiHTOL/2nz7vdIh8Gurq1xRGwl1aeyyLNrdArTiFHMmH4tU+Np+LBuoCjDXMZtSmTkRoSRJHCvUQg5iCkmplzLsSV03949nTCCtRYNPNDRgPPcPdgsJTvzEIeV0A43V2WgnZLPf+qa/XQChlFcrYnGN/p9jERkEbla5ONq/deo13q/ltspYRLy3YUL+Mr2cbszJQSxdmuQwOifrDsMsNIDliQi7ds5/NcItLxyZpwVXvxo2KZIMHtDtHijtS3pU26RzG73c+8hul1yAakZppHG3g8ULyVQK4unOU1bJvKbwyG8aDXCF8LnB/nbY/2izygUGDpdlDKNV7fBmBqOrPEXpXc3tGUa7NgPv5BruR15pKz8DEwzNhP/ado60Ef7nv14Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB9131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cA6+onAzD5JEyob3MX4kIZJ7AkzoQTBosV4TzdP2Milpgd+ltz6tJonrDz?=
 =?iso-8859-1?Q?IcqU5o9xFo4F4wilD/w2xoeeiVlhWyozNEfEKwRgT5yQ52pz1g4jIuDH1x?=
 =?iso-8859-1?Q?3e5/eZJhsHMNx36f76nBYQ4d1zx/952APKRcz1XvBFSka4OwadzKWrwJAy?=
 =?iso-8859-1?Q?d0lZo2Qu3yxfR3LiYM4apXYvRj6VCyWbD1/RZeYAPEIqdZFdqfZC/trJQy?=
 =?iso-8859-1?Q?v/ktXGHHHuPbH/Ac6S+2H46QfPKP1aWoC6e3UjTKkhIS0RUN0mP0JHlRAt?=
 =?iso-8859-1?Q?wyjUjv1z2M+uE51wdmsLYOKH5+jXjXL517k5t5z3p3PbXd1psmDw/TDuwl?=
 =?iso-8859-1?Q?SxItRIq/qHebn6/SrZqpSe4ypAO85Qo69X/hwxVEfoyWVdlXWM9BEH0uvO?=
 =?iso-8859-1?Q?iY55H420uuXa3zTCbFCN2kH4I5vIw8o/0aCmz3LpuTlDPz2zFKEIIICegX?=
 =?iso-8859-1?Q?sBtZoiq1/Zkd3yw3hSszkcYfVYh7j+gp6MOgPm7XmND3mkq/FQmOQd6bXQ?=
 =?iso-8859-1?Q?cbH/ql/3nd77r5pcEM3UvBFRxHzvKcPJ3HN9ed43bCn8B9nkqOfXmEHikG?=
 =?iso-8859-1?Q?XZHkN3PNccwarh4XhFqGtWmjZ3/UsrZ1A1GL94Ugl8ZdgKcJUjzCKeSqYN?=
 =?iso-8859-1?Q?jMNKXpKIWIiILFbnapC5Kt2KBaAvxCYIIOm/qM3dnpZQk17g962foCpBGY?=
 =?iso-8859-1?Q?TzBc3vX/sftGP4DzCBBbHF2RIqYJ46wszLK8/vhd/lLFB7xL10BDAnINAR?=
 =?iso-8859-1?Q?muk7EVMqdBf2nJxcTN1FnSORA7L2486zPONLKgJDEYVlbcua4lfIcHNoMQ?=
 =?iso-8859-1?Q?S4g7VW0IQSGR9Ta1rD44zfWsmPMbNE7IbxfU0h07xVFHxeu87DTNJzi5Sk?=
 =?iso-8859-1?Q?nH3WQ8c6Hq0CRKGw8W409M9QmnI6lV/JyBX2IaKbwjj+x4eeOTwqDYjCIb?=
 =?iso-8859-1?Q?awQAoGhERQKtj6cbfoCN3v3aIJlUx0K+yO7MFMn2fBWbtRrKM2baqWrTxg?=
 =?iso-8859-1?Q?blol1OVYkDHYchXsCLrWRT1gTqNRQ2doyP3dJXx0X46XTRhvvPlpgzW3k4?=
 =?iso-8859-1?Q?ec7WTJUtVlh49l1oW6fbIzTGM1dBHISS/LwfQHMgaFE0gll1dHHs4I/9B+?=
 =?iso-8859-1?Q?xMN8cXy5XrXzIbG5qGDvERBjtc4ojpOBQFBuoSC76+biKrr2WlclIdhj+Y?=
 =?iso-8859-1?Q?oHYaBsF1uxK7pQagemnVuT+iTvaHpRS7++bL4dPlw5W8AgVEskmUie3MqE?=
 =?iso-8859-1?Q?lJmGpEhBnevZF+IjuVqREOJgeDvZccbIOqrl2yQhLB03XTUFQtiv3Dj97L?=
 =?iso-8859-1?Q?za48u8jdouhmhcWryfJwq9cZJeAJlnZWnpXUN/KUj+gn/n6NRMhHQOziM/?=
 =?iso-8859-1?Q?RCbyRWpA+Viwz5+NLLzfk3eTXwqgkUMpp4uFtFztuRIL4oLsvNgD82Duzr?=
 =?iso-8859-1?Q?x7mkB2+2jH/svXPufYEkN8SIwenTw4pe1DYi16erEwuo897fNWqTlT+WP2?=
 =?iso-8859-1?Q?EazYZQYJSdVGgEFyLMEIiRWCLURNj4ariwOLfB0BAiXpXhQenvk9GMCoGS?=
 =?iso-8859-1?Q?2L75GJ0RErJ/elGHt80jjQnqVduyqvRUZMOisRU3aGDGI7gIZwyChpaJ/d?=
 =?iso-8859-1?Q?wNyEPchPW3a4p19OdVNYYPwaM496oL7JF48+PqyqdKtYq0TMpstTic5BmF?=
 =?iso-8859-1?Q?eo1etL4t1GmoQF0C0Yxx4ooWwW7mnta+yIqJWh68YRbWk0VhDUNCxIBYa5?=
 =?iso-8859-1?Q?2bYCnBSiJmpZpicjU2tOdJ66zoA6PJdeEB04PdftF7CqkD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB9131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533fca71-5e34-4c4e-823f-08de80556ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 16:35:55.3828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7beMf4AUgZ+GmUEGym/OgFxg5oTZmBh+ng6u6a4wnWo3Z6OGJ1Q7KuUSXuM5Jmn+3+RmGPwv627RHNrTtmBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410

Hi Robert,=0A=
         Any update on this patch? We could also make use of it. Thanks.=0A=
=0A=
-Vishal=0A=
________________________________________=0A=
From: Gregory Price <gourry@gourry.net>=0A=
Sent: Friday, October 31, 2025 8:42 AM=0A=
To: kernel test robot=0A=
Cc: Robert Richter; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams=
; Jonathan Cameron; Dave Jiang; Davidlohr Bueso; oe-kbuild-all@lists.linux.=
dev; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Terry Bowman;=
 Joshua Hahn=0A=
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with smal=
ler granularities for lower levels=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
On Fri, Oct 31, 2025 at 03:03:10PM +0800, kernel test robot wrote:=0A=
> Hi Robert,=0A=
>=0A=
> All errors (new ones prefixed by >>, old ones prefixed by <<):=0A=
>=0A=
> >> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!=
=0A=
>=0A=
=0A=
IIRC this happens when you do 64-bit division because it's annoying and=0A=
complicated. Ran into this madness in mempolicy.=0A=
=0A=
~Gregory=0A=
=0A=
