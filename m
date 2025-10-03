Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DB79CF;
	Fri,  3 Oct 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521739; cv=fail; b=dtHGVIUYRd5+/1W96a7IcEyZPtxSupH2eV4kOBhgK6FrGg7Vf7gR2YeUlEmb7LdvhJIGv+vMNiapbGxbFnqBXie9kOnqzBxHHRMbjsbz4HlMolZ5fdXkUBQhq4YQFgadlDgz2EpVFg2CuxxABZzNX9TV+6XNEmdMn/xjdx0D6K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521739; c=relaxed/simple;
	bh=yvrX57DMHlTMhqvADdixYAItdA+QpdZRYzEv8nE8Dqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxal4ywIl1T5uoN6ELqjdpAbHxrsHGM9QNoEUQNRQKqG2myD0zqdXk/0FTGMP6lSkpCRTF8B1mEyHgD0SdmOZpjb1dlPvi6I5Ne037e7D8SNQ/IJPOCVD2AtNmuHf7xVWRFs6Rt4rHlBW28SMSdURfxu/2V4MZTa50uslvFswEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0wWxhRj; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0wWxhRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v61/5Ljz9MHECxJN+PPLYCdVVKbPBl+cPNTaLXTP31mhNK7YgehGA2KO23CGdN8Z1/KEDUDOF1WgsWbOMSJiL0qLWe8lL0Z8aaMaaeN/mQHdAIqN0RMoY+tx4X/1W2CnHt+ENR8Mshxg0Nd+0FQzS0JH1uNNngQvIHgfjcoSBWkdVyTPKxlPBKe95fQT+QnkV2Ap7k3TBnLmwiA7ITCW625tuyFGSRMVvbmOLaHc2tTC4Q3eCCNLRUw2AC3Ya6NLF2jD/52mm7QEM+8LHB4aUYU57s9HDlJuK5GuROc5/Tk3VdruVP5zf1S7uF9XGGUZNa788ASqkZA1GPp85Vvq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLZYFnZ3j2IZveq87QSCNt8Z3JkOL+ILN8PshgEdGnw=;
 b=RlFrTUK//tON6cqdsvke0TDixSoVykucyw4dUuDp664p9xc1wvvvaxztPT5IsUF+xQcO2jE5A1Eg2s87zkABhYQJvCWsABYFUjzgxsXKBo40ZXf210NSKggZrX5RlzIb929BMUF0Y6HWGr8jOatGXMNboeGHheLP/eUN+SyEDv9tSxXzIeZe1PwL/brYCzX5SEacNVfRqtU74ubzwXBHZbodghocFGeb6q1uUqpULh3ornSlGVbsVzR93OsgLqoSr1UdZturV+EeP/4MUThPeO/nwpYrlgttdhXImYhZeiIokmR3W2OSYfyEImuc4U6JRUPFAiCKipliw6Hl52ob/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLZYFnZ3j2IZveq87QSCNt8Z3JkOL+ILN8PshgEdGnw=;
 b=E0wWxhRjewGBExJLlsQAyG2YZ/UuedSOK+adMWrK6Pb5e7+dU65jTOMGRKIiJfgnjZc+L5piDrc6X6lsFAO65iA6jwjKgWkpeqet/h8XBfZN99Ptew3HxE/zD84kzfajL0Ws8TzpyyZ/e1Ija0SV26ZF9pp/SpNBjQKQN+27nFzVBLA2Yj6i6E0gdZvXVFKj3XYKy++32zcEP+USw2Fwh4xTQaNbrf5DIBPHzZzvLp+KlCutAnp/nFqLxtFJFf17n3Mawj+Zd4PGzyP8LxSbG+TlRmL1FidukdWsIqewspjmzgUTqXU65qj5NP/EElT6KRUQbJpvyR4EVXj//n+uLQ==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:02:05 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.019; Fri, 3 Oct 2025
 20:02:05 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcNADr7CR1e/ei5UC/raGgi2gvQLSwmzcAgAA83OU=
Date: Fri, 3 Oct 2025 20:02:05 +0000
Message-ID:
 <SN7PR12MB81316FBE4ADDE21FC1F717B0BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <427afe0e-0fd6-4361-ba27-350760e68147@intel.com>
In-Reply-To: <427afe0e-0fd6-4361-ba27-350760e68147@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|SJ2PR12MB9240:EE_
x-ms-office365-filtering-correlation-id: afc78bbe-cc30-4240-8f3d-08de02b7b9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1wLMhRus32rKPt4zPrtUjcbE3yfHa9Y4k6cUiL4PW3qidF164pUczafq+c?=
 =?iso-8859-1?Q?bnVSjs9Xjy4FA+OWtv/+4WBADWi5AtqjDVW/9T8TMZ0S/H1FmIainzy+f+?=
 =?iso-8859-1?Q?GQhQykr9ao2+nGz8kk/zH+2IZQeqgskhFkU5K1IaMHjcb9B/4DGnxYgcV1?=
 =?iso-8859-1?Q?hTqUWgIgEdvVGWTKFGpTlkLTYuqvBRYys1azT9zxRtmt+vrhvgZVzhGdik?=
 =?iso-8859-1?Q?uSOMm5FUFb9Y+wSaYStcGwJkwHFeG01z3iLXImgxL65AdCx0IN7+vsnFQ4?=
 =?iso-8859-1?Q?xVY/zMuI1gQfOiJpIlVm87pTIKtNyO5mYgpF6/vjWvnAIn/8atbEs307AK?=
 =?iso-8859-1?Q?DEVFJAcyAPR81b6JBjcBsRtHUbef8m45aXxR7mKxq5DFWP2nNcQVdwZ5Vh?=
 =?iso-8859-1?Q?1QiEY39T0B1bpx4Ew/2ogp7UgF7i//gC4Cp74sYhFRQo4KY0zSv6EiDsZK?=
 =?iso-8859-1?Q?qv2qFaKMkWFND6IETbnjKYV0dgZezKEOHZNoQ++O+jP2EcXaSX1rOawK4l?=
 =?iso-8859-1?Q?ZKz/eiYt83dDtrOW6Q3HrKGAFXxXpcnf8bJe3cBUkL0GLfRfJmUri2xvUK?=
 =?iso-8859-1?Q?IzYk2aUeKDvxu0Fy3ZR9UMx48vBgIjztIc9GoEqx70Ho44nOQS/XwMH7yn?=
 =?iso-8859-1?Q?Msr/BmolMwulhGCf55XFTPh6jV3h5D0ujHFqggJ0/Bbqn+CVUHCCA3I5G4?=
 =?iso-8859-1?Q?4EoOiYhlwLj1aOJc5eRBuWlAiWbYb+uERXBULoerQHJpXN9OBdAJLrfPeZ?=
 =?iso-8859-1?Q?bHMCcljRh/g3m0ypiLfIzxAfP5EnopJ7b4Nv3II5oEtb0MNMbt5kk4YfXW?=
 =?iso-8859-1?Q?5oqq2T+dSqanSJC/sjiXzwzdWUimsH0YOlnpVpPTQLoXFfvyM8r8V5DBqW?=
 =?iso-8859-1?Q?xVonDkee7pwRAslB0D8TxHdX9Qs1pU2x+py5XFg4BsMuAI7HdiVJeHkHZU?=
 =?iso-8859-1?Q?W/irQW7W94pkREmYywWhtYGyJN5Ik3frVBTnnGSuTHzLph+LpDJUs5UySe?=
 =?iso-8859-1?Q?oFEq/5E/LmMQup9LVuGKhUQsH+fTE8xN+XzeHA7VY7Cl2vX8D6QVuDLidy?=
 =?iso-8859-1?Q?mA6HZ/TEa1EUgngrnRPVsqRgcZBwzXYgKTbVjuGATNuNyWuJdF1NxkhBXK?=
 =?iso-8859-1?Q?DhrJ4EpIdl2HGFmY7mP8akcsqzmNOxyvUSaVKrbwWl0yqFmvo7hFZE8xSK?=
 =?iso-8859-1?Q?rKME4oPHMWrZvEBDJ2XoOWcH8Gzwkt6lcTJ6v2mdtAC83Jq+wNIQ/GTpak?=
 =?iso-8859-1?Q?ngzYGncTkSyY7uqN5gNXyRVKckbCanxugWw43tXRPzDTUwOkJHUBTGMAde?=
 =?iso-8859-1?Q?Kr6TPsQjfY+VdLE/lVZZ7Xe+tsMgwY8I1Q3TB5flOC8Y1BOQjY7O6Bogwf?=
 =?iso-8859-1?Q?hC0efUqSc46PjJPalv100ja+GyTFbhxRi0R3GHYYZYD3yN7GXQ0W9gcktV?=
 =?iso-8859-1?Q?xkHv0zTuQRUmzqN6o+xnIaxTi/0IBFjP4CoKVoeM3NnCX07b3sVYdAuLPC?=
 =?iso-8859-1?Q?ndvWZb6pmsskt4SyHG92kSRqj4qLCGTq7oCfYQg7cIYG907xgOSmZFHIAD?=
 =?iso-8859-1?Q?kLE9W2SbKFRD9Div2BwXDDLoVbJEIdAm1PFDo0hwxXtjhH0Wkg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lGgUC/7EQijuiz2TEdCC99LUtGQUsNHSEpJJupUZptiOZIQwdDw9nOMi8E?=
 =?iso-8859-1?Q?sKFnYjpm5tFrPH2rmI8LDfRmqKdzSPu9aohVeuJ5/n1q1IdjQPqETBQCKm?=
 =?iso-8859-1?Q?+CwAi35CiJLO79MUwLXH+/uLBId26dSXid25iEHLHNQVmHaaIFU3OKuTsm?=
 =?iso-8859-1?Q?pCdBOgJxJZ4TTgMuJquF76J1g9DvQE4n3iHVcwViKOU0/nfXCdL0TbWZL6?=
 =?iso-8859-1?Q?uNBhqd7cMpXNjZeUhvVlxUVtv2eKr+tpuRTrsNCY9UM1rSAzOPGTSLjhYp?=
 =?iso-8859-1?Q?D7ilnMTkQ/5K42NkHL7wEJ71JjKbNDSy432SRCk6PB8yjSAEQeaY8+kmur?=
 =?iso-8859-1?Q?WFDyyOHkl25RlY+pnS9bGUHsEj+ryz9CGdHN5vXNoqOwH6ct+HetB0jZyZ?=
 =?iso-8859-1?Q?swQ5vcyl2+si4CF6huw+cAnzOUf3/BWhzxgT13LVcAADopwBw4GXrel5Xp?=
 =?iso-8859-1?Q?WJFVkG18jIuaxcqNdXBVQ+0dk8lxKiI5VgPCTK0V0+ZuYVzMeeB3PJg0cJ?=
 =?iso-8859-1?Q?2sT7JaxMKKaKfKt3zfSBCthRoJgcB/SRCKrSUmagVpCrBk1oMIhQBRyoj6?=
 =?iso-8859-1?Q?suyA25WEs/qw0h20nODIxRkVGabTNC1MB0WB8T7wGx2Jizr2wwfkE7599J?=
 =?iso-8859-1?Q?j8Xkr3zvNwYMlMBLjAtyF6x74uPBuzy7f7gdODIibMvwWOgrcRJ1/7BsNj?=
 =?iso-8859-1?Q?OHDHUXk8OUQpo6h7vOllAtAWo3srUr77KxD2cSfaQIsfcMq3HSlMtgUOKQ?=
 =?iso-8859-1?Q?4Yut5VeuFSqeuoSwT5aiVG/XEJDLam0iKOCs/PRm4pxSjfAKSDc7Tvd8Ny?=
 =?iso-8859-1?Q?ozW2EyPH9ROF2Ap3AQFBNbDvOz7t6g2mlVBA0kqL+3KDjCyrELXUoVu3Rf?=
 =?iso-8859-1?Q?zMUoSROjeN+Xu1hGSAuAjkEfj7M3u1S1Gw+SrnvT+pU4rL0QT523GI5UPj?=
 =?iso-8859-1?Q?NEDbC7NgUc7Gc0EVpt/OiaBz0F/W46tSKMDbfHnv7LjcJk0x3FbSJnDtUd?=
 =?iso-8859-1?Q?McI5epxVjy7eC9bgwidvy16iFnBj4fZC6xL1EaPQnKGYmnsp0QFL8jgTV8?=
 =?iso-8859-1?Q?ub1dHbDfszIaoY4FM8GhIpvSvY0ZGZotsrKP28qhbIxVVuz7gD35F+AoaN?=
 =?iso-8859-1?Q?agFW8MXSzEA8DsAMd4Sb+zNbEjHxD8A6RSxxnamNubDPvUZFHdxT+gl7Ro?=
 =?iso-8859-1?Q?POecMMPcwozJmMCwkNrjbxwEaqP/No7c5AkuCmQ7QQ8EP9CZRhRAEY0ayf?=
 =?iso-8859-1?Q?KxhGOBQ2ljkFTum6j3NfNVWDviGBDPBuJIVWUprN4RWSP/F4DqfwkXGTZL?=
 =?iso-8859-1?Q?xKgv4lfN9RtS26D4Vx5/7yvPUAp5kQouYtH1t2rM5Yii++cALSDsbDvEB2?=
 =?iso-8859-1?Q?GNQy8IHOhtS8nuBxlmUw9j7u0aH8HyYR+yZe5srssO2DYEDK88eeeAC+oH?=
 =?iso-8859-1?Q?4YvN9xbi1EHXUVovpEbWmjozzNwt0LI3azXzkYVT1BZ7yDicudtxJmTvPH?=
 =?iso-8859-1?Q?gg/k9itoml56iecrrsW2rx90iE/77mPN9EAXL7Y7ChuEBN4pIWbJZ2cajm?=
 =?iso-8859-1?Q?pm1lYqduOo8/1tvOU1sNN3XIg0MqQwFlvulhvMuAspyeGiNrpd3wnwed9c?=
 =?iso-8859-1?Q?trGJw9cch1ZLQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc78bbe-cc30-4240-8f3d-08de02b7b9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 20:02:05.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMycua6XzyhNAzqhtwDoSU3noS8zFVU+8YEnG6GoOxrsN/s2asmBbB42vqUMyh6wEMVQnafIP7Vep+WYZSZTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

> ________________________________________=0A=
> From: Dave Jiang <dave.jiang@intel.com>=0A=
> Sent: Friday, October 3, 2025 11:20 AM=0A=
> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vi=
shal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter=
; Zijun Hu; linux-cxl@vger.kernel.org=0A=
> Cc: linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders=0A=
> =0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On 10/2/25 5:59 PM, Vishal Aslot wrote:=0A=
>> init_hdm_decoder() fails with -ENXIO if a=0A=
>> committed HDM decoder has zero size.=0A=
>>=0A=
>> The CXL spec permits committing zero sized decoders.=0A=
>> See "8.2.4.20.12 Committing Decoder Programming".=0A=
>> It says,"It is legal for software to program Decoder=0A=
>> Size to 0 and commit it. Such a decoder will not=0A=
>> participate in HDM decode."=0A=
>>=0A=
>> This patch updates init_hdm_decoder() to return=0A=
>> -ENOSPC if the decoder is commited with zero-size.=0A=
>> The caller leaves the decoder allocated but does not=0A=
>> add it. It simply continues to the next decoder.=0A=
>>=0A=
>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
>=0A=
> Hi Vishal,=0A=
> Next time please post the next version of patches as a new thread and not=
 a response to a > previous discussion. It would make lore [1] viewing easi=
er. Thanks!=0A=
>=0A=
> [1]: https://lore.kernel.org/linux-cxl/aN_cUPzzwUy-s36n@gourry-fedora-PF4=
VCD3F/T/#t=0A=
>=0A=
> DJ=0A=
=0A=
Yep, will do. Sorry I should've checked before hand. =0A=
=0A=
>=0A=
>> ---=0A=
>>  drivers/cxl/core/hdm.c | 7 +++++--=0A=
>>  1 file changed, 5 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
>> index e9e1d555cec6..50164fd1b434 100644=0A=
>> --- a/drivers/cxl/core/hdm.c=0A=
>> +++ b/drivers/cxl/core/hdm.c=0A=
>> @@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *por=
t, struct cxl_decoder *cxld,=0A=
>                 }=0A=
>=0A=
> +               port->commit_end =3D cxld->id;=0A=
> +=0A=
>                 if (size =3D=3D 0) {=0A=
> -                       dev_warn(&port->dev,=0A=
> +                       dev_dbg(&port->dev,=0A=
>                                  "decoder%d.%d: Committed with zero size\=
n",=0A=
>                                  port->id, cxld->id);=0A=
> -                       return -ENXIO;=0A=
> +                       return -ENOSPC;=0A=
>                 }=0A=
> -               port->commit_end =3D cxld->id;=0A=
>         } else {=0A=
> @@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxl=
hdm,=0A=
>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=
=0A=
>                                       &dpa_base, info);=0A=
>                 if (rc) {=0A=
> +                       if (rc =3D=3D -ENOSPC) {=0A=
> +                               continue;=0A=
> +                       }=0A=
>                         dev_warn(&port->dev,=0A=
>                                  "Failed to initialize decoder%d.%d\n",=
=0A=
>                                  port->id, i);=0A=
> --=0A=
> 2.34.1=0A=
>=0A=
>> ________________________________________=0A=
>> From: Vishal Aslot <vaslot@nvidia.com>=0A=
>> Sent: Wednesday, October 1, 2025 8:57 PM=0A=
>> To: Dave Jiang; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vis=
hal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter;=
 Zijun Hu; linux-cxl@vger.kernel.org=0A=
>> Cc: linux-kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>=0A=
>> External email: Use caution opening links or attachments=0A=
>>=0A=
>>=0A=
>>> ________________________________________=0A=
>>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>>> Sent: Wednesday, October 1, 2025 5:46 PM=0A=
>>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; =
Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpent=
er; Zijun Hu; linux-cxl@vger.kernel.org=0A=
>>> Cc: linux-kernel@vger.kernel.org=0A=
>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>>=0A=
>>> External email: Use caution opening links or attachments=0A=
>>>=0A=
>>>=0A=
>>> On 10/1/25 3:03 PM, Vishal Aslot wrote:=0A=
>>>> Thanks for the quick review, Dave. Yes, forgot to put the commit messa=
ge. :)=0A=
>>>> About the copyright message. Should I not be updating the year to 2025=
 in it?=0A=
>>>=0A=
>>> I wouldn't bother unless you are doing massive changes and in that case=
 it would be adding NVidia copyright anyhow for you. Also, typically linux =
mailing lists prefer responding inline and >> not top posting.=0A=
>>=0A=
>> Ah, understood. Thanks for the mentoring.=0A=
>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>> ________________________________________=0A=
>>>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>>>> Sent: Wednesday, October 1, 2025 4:28 PM=0A=
>>>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield;=
 Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpen=
ter; Zijun Hu; linux-cxl@vger.kernel.org=0A=
>>>> Cc: linux-kernel@vger.kernel.org=0A=
>>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>>>=0A=
>>>> External email: Use caution opening links or attachments=0A=
>>>>=0A=
>>>>=0A=
>>>> On 10/1/25 1:37 PM, Vishal Aslot wrote:=0A=
>>>>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
>>>>=0A=
>>>> Missing commit log?=0A=
>>=0A=
>> Yes, will add one in v2.=0A=
>>=0A=
>>>>>=0A=
>>>>> ---=0A=
>>>>>  drivers/cxl/core/hdm.c | 9 +++++++--=0A=
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)=0A=
>>>>>=0A=
>>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
>>>>> index e9e1d555cec6..97a5f27f5b72 100644=0A=
>>>>> --- a/drivers/cxl/core/hdm.c=0A=
>>>>> +++ b/drivers/cxl/core/hdm.c=0A=
>>>>> @@ -1,5 +1,5 @@=0A=
>>>>>  // SPDX-License-Identifier: GPL-2.0-only=0A=
>>>>> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */=0A=
>>>>> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */=
=0A=
>>>>=0A=
>>>> Stray change?=0A=
>>>=0A=
>>> No, it was intentional but I understand that for this small update, I d=
on't need to update copyright info. I'll undo this change in v2.=0A=
>>>=0A=
>>>>>=0A=
>>>>>>  #include <linux/seq_file.h>=0A=
>>>>>>  #include <linux/device.h>=0A=
>>>>>>  #include <linux/delay.h>=0A=
>>>>>> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *p=
ort, struct cxl_decoder *cxld,=0A=
>>>>>>                         dev_warn(&port->dev,=0A=
>>>>>>                                  "decoder%d.%d: Committed with zero =
size\n",=0A=
>>>>>>                                  port->id, cxld->id);=0A=
>>>>>=0A=
>>>>> I wonder if we should make this dev_dbg() now that it's a valid case.=
=0A=
>>>=0A=
>>> Yes, makes sense. I'll change it to dev_dbg() in v2.=0A=
>>>=0A=
>>>>>=0A=
>>>>>> -                       return -ENXIO;=0A=
>>>>>> +                       return -ENOSPC;=0A=
>>>>>>                 }=0A=
>>>>>>                 port->commit_end =3D cxld->id;=0A=
>>>>>>         } else {=0A=
>>>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hd=
m *cxlhdm,=0A=
>>>>>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm,=
 i,=0A=
>>>>>>                                       &dpa_base, info);=0A=
>>>>>>                 if (rc) {=0A=
>>>>>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>>>>>> +                               put_device(&cxld->dev);=0A=
>>>>>=0A=
>>>>> Why put_device()? Should we enumerate this decoder instead of pretend=
 it doesn't exist? essentially only a dev_set_name() and device_add()?=0A=
>>>=0A=
>>> That is a good point. The decoder has been committed so it should be ac=
counted for in the OS.=0A=
>>> I'll remove put_device() in v2.=0A=
>>=0A=
>>>>>=0A=
>>>>>> +                               rc =3D 0;=0A=
>>>>>=0A=
>>>>> Don't think this is needed since the continue will put it at start of=
 the loop where rc gets written by init_hdm_decoder() return value.=0A=
>>>=0A=
>>> Agreed. I was being paranoid. Will remove it in v2.=0A=
>>>=0A=
>>>>>=0A=
>>>>>> +                               continue;=0A=
>>>>>> +                       }=0A=
>>>>>>                         dev_warn(&port->dev,=0A=
>>>>>>                                  "Failed to initialize decoder%d.%d\=
n",=0A=
>>>>>>                                  port->id, i);=0A=
>>>>>> --=0A=
>>>>>> 2.34.1=0A=
>>>>>=0A=
=0A=
