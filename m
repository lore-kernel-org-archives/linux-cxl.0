Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107971DE4FB;
	Fri, 26 Sep 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909165; cv=fail; b=Hyjc0xcqEcnV1wh41dYOdi/0GM90vJjb3F15YlmP+CFqTKrQ7t8QGqRIgFOeD5dlj1FU9OoJ61cUDbAb4TCSgE67aHhEX4bhw1i7DwWB+S6N+VLC59kPp8t4ERM65wb8faKDt8uoi3jrpXtO+hQ88ccx8may1MddmnL45IuKGSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909165; c=relaxed/simple;
	bh=l9EXNBd7zmEE9ay32mYZ1gIBtNyuXWmfRUD4uz+J1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rVc3mSvtYOGnE0RRqccmd/dZDsJTZso464ERBx0g+LK0PLU+WKRzamXcGj0NnVwi3jN+Miap5T+F1QRG3EqRZCIll9WNgIIC3MPQ6yFHCYLeorr+VttXTb3GFwcqcQEgTT3kXNv+T7Kbr498eVxMzDfddXlyU5Q99+oCyOWk1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1lhLwSbz; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1lhLwSbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSI4YD1m7VzNXJSsF4yW+93muU7AwWGE87BHW3h9S/OE1c03OxigAG0NydCo1PD/OhTHCP8yDwm5lNuOt8e2+ZqDAcjzMMelaTHGyjsley5jY5WaASdnuj7gc3ShbqOlFHuiJm1oLXhjJraQK11LcEA9W4goVCcoJwPaxp1njOwc6H+W+SMrFf+iIUaK3JfzYYQZeiotX1dZC+dALq/PlcbUaTygy5bGqTFBHFtkp1Yn3NZnYCnO8P0xyMT0Ng1+7lUImD+m3kpiqFQdfrPfTang3uexRJpeVNNc+wVD41TGYo9Iix6ZLwdG/C4XB8g9gxBm+Q4GM7okz1W0KfXMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IawTO9fvyiQbPxHKqDuRZhKrCXM5sXbOzocURnGpTs=;
 b=JZ8Qlcncu6F6cQI3gQlIhpafrE0hasNbDDIdxICjnRCyPLThHe/+kZC59h0oc5W4uml+IjtiDgmanzShhpeanCpSpnQIgmrfslejm1/hahUwqxowHar2mhB7e3p3mtPkPwxebp2U29HM5F5DWTQob1rpBkHe36jsp2ezZBAR6NntlB/xFFfkYHBwmOpC85/yUnk+6fjYIOsmhTDMkAccjMTTqW5W1sCNUY/fy6bOQiBAcOIoplueNAPTQ5NhZEqz/BS7U6G/iceVNXsOBPUgAG+aTd05Uf/t8mrgBsIuXkkI5ltS1xDggIFGdmwmPAOPLalyvt+dv5fe1PA13R8v6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IawTO9fvyiQbPxHKqDuRZhKrCXM5sXbOzocURnGpTs=;
 b=1lhLwSbz0E7Fq8cUaeX3vaFFeRc9P4Q0CIl87L5UlXI3I7pTZHup29ZtG87bckRXTMcr4i6l9IRtAAGTAXqwaILgFVR1Bh8qQ340ZiBY9egrv+HkNwbPWPrhI7/0VOy8/nwgoM0YXDPpqpwW31P6u+GGSeixmmHhaBuzhSpbrNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 17:52:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 17:52:40 +0000
Date: Fri, 26 Sep 2025 19:52:36 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aNbS5NL7_KXs42VH@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-2-rrichter@amd.com>
 <aNMTz5d55LqXDiek@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNMTz5d55LqXDiek@aschofie-mobl2.lan>
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: e57a8438-6f56-4958-4b61-08ddfd257cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cDyEwNq+lcLGnTZ4lVOhNuf5tJbHfOY+Ewss0NGXqCmM+AXBYhswBz93fQa4?=
 =?us-ascii?Q?ULmDOzsrQD3cU0HWSnQex+FfGxLdSGRxxtISxmTzWK3N/4DWIb6WaXiab9yx?=
 =?us-ascii?Q?ONLNapmlX4hCE+9yP2lmodSnbcvEW4TS3PVIokeZJgsIKez0ob/uiv7z4Erq?=
 =?us-ascii?Q?XytcIW6IazmleSEdD4qS3HiOpe2GSLc3WTXEfo4myOLRZSOBAc9PKLhcv0X6?=
 =?us-ascii?Q?oe2GgxoPqSOVjonWot6anbXqoYl715WEPpsMe0xAEjqq3oJ7YkNP0+cKelTw?=
 =?us-ascii?Q?7exOvZVPj0/XNVvfw+h3ZR7UTL7sS1TFIfwEU8MsYPJ7NkXJRjYitdLKuviY?=
 =?us-ascii?Q?IsuicbCxE60ifMcI5cdTKG2CXzzp6PwBucX7TWaEOAjxcsT2fjSRLhr1HzuA?=
 =?us-ascii?Q?SzFfY/P+6EQvJJbxQArZ9p+/GcEAB+bNW4vNFRwb+8lntSw7MVIjN7EfOsYV?=
 =?us-ascii?Q?j/Lt/VtLV9BFSzYiSCqBHopZpuZ2200Wt+eEQ2VK2At5yjLQwi8GT3151enm?=
 =?us-ascii?Q?Qmhu4JUN1HzqWv5Mj35E43Gh0ETgaTlqYYV0tFgXExSnNIMNl3MyZiFgor7D?=
 =?us-ascii?Q?pHf1tOu8kjvzZ/ocgOQpHqcrfHdybPSbETCYCTGVb7qKVat8BqrhHa5DoKyu?=
 =?us-ascii?Q?Uy+GCzyyEmYyNrtmHjbcfQVSe3LrEMKH0NSbTukliUNWo50616ZWHrq7WlqN?=
 =?us-ascii?Q?tI2FZe2x4lOqcD0Jxx/Sscd0RtrmwyflOfqEvk1PbRAZ16go0AweM4D1sUK5?=
 =?us-ascii?Q?SnQ2aL0yHir/x+aj1BA2z//s9pxVl803MNLJO1KPM6AZz7piKw+4xhbgte64?=
 =?us-ascii?Q?diupqSk1Ay8SjtgxT3kHlac3dDKZMA8XWZBYblVjLudReFExDsXrNe/U4dpf?=
 =?us-ascii?Q?dV5x79O3o8sWwvEuxDntxst3QgVG1Qx4vx5aM4WdZ9tY8rvDoqUMoDzOS8m7?=
 =?us-ascii?Q?t9339AxfGIWe9r42o/FbHeqVfcrjd2+H9eyFae/KxVGvGzj82AtA8NBdRv1D?=
 =?us-ascii?Q?iedvtGkcYGAMWVWtnwcceNgHffhwc1azQVxmcBWAZ6ztg2wnfy4eY76kcpqC?=
 =?us-ascii?Q?L9t1ByYkqxijaQEtYK+BXLrkmxqphnS99cQu66AjA/MiWW3fpZClENdhmZE5?=
 =?us-ascii?Q?EwsUhkND9T4rqUprMRprPXQgBrg26VcW6Vdu6g3tTfVY2vTnA4DwpBFI4Ysj?=
 =?us-ascii?Q?n/MUwkPTQq5cO/vIzswhxmzEJpEvVFMuXTSYRsVlM0hzjEYoqpBUkx1kStY0?=
 =?us-ascii?Q?CD738X+uek4QCIS1gyAbEsTIGhGuC3908+N13SYvB41g1GF522d/172iEQ1A?=
 =?us-ascii?Q?AmBlfDbSYwXJ4j/kN27eNLyZETbTbIRCdoeEajvhtD/mYR2fYIIcidiA+p4r?=
 =?us-ascii?Q?U/iD1J1qmkvdp117uJ/mUI2CruYhufMt3rB44Ior/CQQRcN0dRk1QBywwfEg?=
 =?us-ascii?Q?lykVa4zby8ewwh9Gp9Qa6wfNaYLNxbqZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fL1/RxGTx2j72QsqvYNwmeguoUldC4S5flPlMgROnQTSZIqpN9KFb7fPAKLe?=
 =?us-ascii?Q?Se7O7TaRQqmOhf23TWIpQr0qbCt8Ah09v4+kUE2wqyYXVJA92pxSLkG8mxzw?=
 =?us-ascii?Q?lCuFeszIH5KR7PNJV9/OH1eZOpxJgFFUiUlt+0Mas61gGy+EoFuomrw5el+g?=
 =?us-ascii?Q?skGyRganCheZfjLMEaVFk5deQzpoJpJbpBQECbqSrxXuk1A/qoI2MnnWOKgC?=
 =?us-ascii?Q?CWN809L7N2SNgG09lzXlPdwE7jjraxLqwWEsOf8dxIwMc14AgRhG3KffAk5c?=
 =?us-ascii?Q?Imsdc7Q1YcufkLKaJRzSzHCy/KoT65WGibDcKjvudon9rpjqOboCPMvL1viU?=
 =?us-ascii?Q?yGarnxp690OYkZ4bovph1C1k8sgAr4E4WT9Vcn2ZVyaQqQsi7kRWJZkeoUc7?=
 =?us-ascii?Q?AMsTTokXoFyhqso/TxB6ASPOzeE5nOhA8S8bSTOGFxE2VfTyzwuaqhgkhsEb?=
 =?us-ascii?Q?by0N2Yd5Zs5HBu7/Ilj4JlHRe/YUVUZxzWffjodUsoBMPSLVKdlxZ1s+VBTQ?=
 =?us-ascii?Q?n3SZaDLKWWoafD+tIKAthtkVSQHCCX0HAeUubxKIaV3zT2sM6HkxgwtPgw3m?=
 =?us-ascii?Q?+DjW7JA0FdM+mmxjPVyfgWx8lE1xEy6jc3lloXn+tjDDeC32ZmktGLXhbd11?=
 =?us-ascii?Q?laoExT1KCclBgPBhvWaMc6iZVGokR974mqgQpg5DFMXyJFVwpqKJfYK2f/di?=
 =?us-ascii?Q?3GwXraJ0b1oXKmQn4KUnvXTi4tnm1M5ybJ1L/msRSfh6A01qGneIllAVglGU?=
 =?us-ascii?Q?q9uiMQl4QVDuSlqX8S1Ckv6ID/7J/EOGxrF0mSeAEfeJhZgPf9TiQQD63kff?=
 =?us-ascii?Q?bevGdiGnLDB0ay8gzFpVIbLBiZ6lTEkQrCMeBAxdqebMG0Cx2CRU0jnW/DR/?=
 =?us-ascii?Q?9rZjegDqrYEKYQUQzO84rX7PtZoojyW7m7PJZMsBnjzK0AxFiJq1+SR1ld4g?=
 =?us-ascii?Q?lnS1C4FW8u8aoRolGhudbNc9wkeEvinpqM6pQow1A/c9j02iZz8CDU25ePn9?=
 =?us-ascii?Q?LwYC9Iyy3zypw1b4O30sP4KSe/VceClHToTBnthYC2cSpDVpV81GwZLu1dXh?=
 =?us-ascii?Q?YJ86xKnbOXr2ZuEvK+Nmf/HKAe93txqBaaO7tw7b4QinibmFYsKnjn9wSGRk?=
 =?us-ascii?Q?qomQkvOSShJLuzPPDC0ion31hHw/zAenJHt1GQx0gYW+sD74k6Cloy6S9qW9?=
 =?us-ascii?Q?EmObq8jDE4jnIEP+eygXTdrz+iUo8fwaDZWAbFNJ1WeXsWrZlpgLgu3ttAGu?=
 =?us-ascii?Q?qb4AuYpZi1IlWERDspdBBzsMclRUgcX+ORqMFqAf/pDTwwof2nnECuuAj0D1?=
 =?us-ascii?Q?xLOORHrb2pp3pF9vRFWAcmDKP1SpTu9Ms6Q41VcmPIIlgES1VCFP0r59wIKE?=
 =?us-ascii?Q?Xz94NuoPhGAbkym6HrJbawo5XqnHyef1WZMBFmkNErK8uNHFuqvVlymi6swq?=
 =?us-ascii?Q?ZzDuW4vaSNTlSSlRvPDdnEYU5sT2ZZ1pstLDrR9MZrgVczWdhyPptDsXpQSc?=
 =?us-ascii?Q?CxnrU6i3haAX77AEmqCJWpoC96y1fOH4D7NkI3k3gSOCXWoLUK0T/qJxe2Cy?=
 =?us-ascii?Q?cFBuoepex82x/JWOXQiwr8ZhvThM6ruIkjYZDs7g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57a8438-6f56-4958-4b61-08ddfd257cbd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 17:52:40.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kJzV/lAp+kSiIS9/HfD/zYz/5fb/VQmu7qsHVBKw+K0S0avEXjfUGxCUppmmW7Gfug5BV7967DvOuvDQsvJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

On 23.09.25 14:40:31, Alison Schofield wrote:
> On Fri, Sep 12, 2025 at 04:45:03PM +0200, Robert Richter wrote:
> > A region is always bound to a root decoder. The region's associated
> > root decoder is often needed. Add it to struct cxl_region.
> > 
> > This simplifies code by removing dynamic lookups and removing the root
> > decoder argument from the function argument list where possible.
> > 
> > Patch is a prerequisite to implement address translation which uses
> > struct cxl_region to store all relevant region and interleaving
> > parameters.
> 
> Where is the follow on patch that makes this a prerequisite?

I changed this to simplify and rework the argument list of
__construct_region(cxlr, cxled). Later, this changes further to use a
context argument: __construct_region(cxlr, ctx).

The patch additionally simplifies the arg list of
cxl_region_attach_position() and it removes the use of
to_cxl_root_decoder() which always reconstructs and checks the
pointer. The pointer never changes and is frequently used. Also, code
becomes more readable as this amphazises the binding between both
objects. Overall, I don't see a reason to use to_cxl_root_decoder() as
an alternative to avoid the the pointer, which would generally be
possible.

I will update the description accordingly.

Thanks,

-Robert
