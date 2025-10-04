Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA38C11;
	Sat,  4 Oct 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585777; cv=fail; b=N6b4CKVIsm4+c9aDkOWeC3Zjj0RBTUcoIb5T0XMJMStGrmddLfPEAMttxbP1koa+O1jcKFmGl0xcvXpVZo8ELeHqSpSSpEvCGVD55s5cdRyZTLA57D/brE/g//X99cbqYR6WpI1naDeGPOyKDArA8l4Qq9jC6qJXHUR2vhTWkPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585777; c=relaxed/simple;
	bh=M7deicTBMEMigRE6ZY7Jyo+DgRsDKGwgj/q+9xCcGko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRNprUUWtvkse+QQqcyekoDIf4EbSjvVNUxWXyAPmHtoXGW/VCFX5l3c1h72Q0lkjTvJxL5W00FN/53lOyKsR0vmiXZq6mfl19TpTplFj0s7lYP4/40N7mA5107LPfrz9xG+5lu8VNEs8f96b+RFWBUqq3I0ka/KnrMRqdfDB9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WFnQX75v; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WFnQX75v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIrU4+0IUom2/TV0eoeHKFrLkaCDrA2OzEYusZKR5j/8HQQVrWh9NYRKAEJRKRXtYysZEGuXUKh/e03HozfsnAUrqZDzCXsqSfB2VnCvywapNyHjBgXZrLornZMo6+UG1cPQDwnSaEeFPFDuz4Er/nimYhOwvvWT26qJhA5TqPPCDjjB8vMJF4caA4dh98Deb1fx7bnwbQUyQm3Vu99Mq5KCJUr2xTDCp3hLD+vc/KfOwAI6HxrHftR5Dzho7Stdnit0jOa3AAtVDuHc4x06LcwZLjtooXLpWchKMjrschfPrVbZ2KroBLwlabjqX6jHirb7T9m7d9EaOauKw/jl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVKo2UrM8Ko1VEIE1jI5RJr3hwhiPdZnnK+CLBIlglY=;
 b=MtKy2OEHWvF8V5ywO9SMkjIXpcKGFGySlAgbNZa3+WiDFd9sa64s6NYfRxFfayCz47DGFu9NPHukqrVnJDAnHx+QY7X7gqlZXAxvJ6R6A/4ujjnrtyD4xkCK6rr2YhcqlG6jRzabPXgnO7BCNa9OLK4YuOxP4OxYCl2VuXNlheq2L/wwVORwWZ3eYKrm2eGmwkMMOFkFKYJX2udCnuwyYVvfbR5HZ2Tf6hwDzdaDNkSYjjqjY8Ot7Wc1Al01bta3Iw+Q5iISFSqKPsh2pXJu5AfMcOxovjMmuQiz4K2ZZcpskSk6cMMI6GdX0bQpCH9DMWULRWvvu9/IbY/E0lWSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVKo2UrM8Ko1VEIE1jI5RJr3hwhiPdZnnK+CLBIlglY=;
 b=WFnQX75vf1l/KE9q22m0Y/XCUMEBJNpsx0LDbYIURbuzQhuKJFvOPq2mh6QnKJnaVLVgeeqhLgBA1j3PlBlXsVWuuCmM0tFmoXS4u92TuFefv8RbQ0x/FF7ZIJxScNLddJCA2Uudq/gsDJFkkxFyA6J9AVWauWuHC2glwvIRFsYalzPUQVJVrrm1w3ioFp9Qa4sy+NyLeftG7daI1eQiz0zszGS/QoMeLCZmcOx4WqsUHazhqGUE8Z77mhMRl/L5gQl4dmHGbY9Z4dfSCQ2wQ91sKWKDzP8S3wOBgDioPREoYCMZgYGMJoDKYQf874j6Qm7D7qiGiS7r2CAoMjPkGQ==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.19; Sat, 4 Oct
 2025 13:49:27 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.019; Sat, 4 Oct 2025
 13:49:26 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Gregory Price <gourry@gourry.net>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVLSuWlYAgACjEoCAAJ6eZIAA4FQAgAGH898=
Date: Sat, 4 Oct 2025 13:49:26 +0000
Message-ID:
 <SN7PR12MB8131CDE3909B30FCE3E24B6BBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F>
In-Reply-To: <aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|MW4PR12MB7484:EE_
x-ms-office365-filtering-correlation-id: 866789fb-40fb-4d37-eb7e-08de034cd55f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6tSW1OTRuH2HDGFKE0AlJ7ymR8HtEyGLq40qWhm9MDfOAo/Lxqq3gN9Uzy?=
 =?iso-8859-1?Q?0iFdxsf55eJTUgiMroEdu3HnsJdjsb17oSVp/nHQA4tRUceyZ/+2IibHII?=
 =?iso-8859-1?Q?xf00lq3J5oYM9nZsQYvjoJcv6NvM/n9ftl5JPFAypid/t2NZ8PIsEvAPYu?=
 =?iso-8859-1?Q?GaldGEIMJ8BjCePgf+Pir+hZjKgSYt36sVWlzKbk/3ZU3VqU6edv/cXqfr?=
 =?iso-8859-1?Q?fUkgfl0i570DPUUiRePzEaLu9iMmDnFfq7bfArJ/R9gvF6S0c3J02ANpUm?=
 =?iso-8859-1?Q?2m+xFpg4Km6oFd6tGmou+SQW7oXY9e00mctwpL5+yf+vdVDjkhHGH0kTnv?=
 =?iso-8859-1?Q?t+gmtjmHo+aYp9so22mKCvDM86EXPufhPicrJeqWzRlW77q/O3pwAtrhrl?=
 =?iso-8859-1?Q?ZLA2OLSMeWbMtwLEuf+4ChjpJO99X2+SLrkHykUhVUBTUxaKzEVPtErzS9?=
 =?iso-8859-1?Q?gaf8LgpJolBD+rSozr+pHyqjRDoJg76sfHX+YqXd4E6MHSHHJd+Hw3evoM?=
 =?iso-8859-1?Q?W7nWyyoFiVvXYznpiE9c4GpfNHPETLfGJsV7L2sjQbr2ShoheZSiJeGuQB?=
 =?iso-8859-1?Q?YWjQKLSILij07iDJOwy4JJpC0IERWo46u61lsO3+Ukj3xLxqZsjQKdJlg5?=
 =?iso-8859-1?Q?xR2UQBZGJODvp2bboneL8egUM8GXSuemm/63OhzlFYbF299+RGMujdmiP6?=
 =?iso-8859-1?Q?9tuqDsCaW8JPOp7D7R3NgOOgI4ML1j1pClvkycxx8j2z1Mdy2an+4eyvjA?=
 =?iso-8859-1?Q?0forznsfBZ+q8j7U2h4iSOIBa4ZCta93BMBedks25xTIb5eLPCPMcjO1XH?=
 =?iso-8859-1?Q?wLXsLrEtK+t39h8/xxYcJtAtPSmIG2CkZUlQUErng7yQfPlkMYzmOZWElH?=
 =?iso-8859-1?Q?yiddUIUfH/hT433seUcZpVZsBcxYZr0z3OdVpHVN4R4TT/pVKn7dKm+m0n?=
 =?iso-8859-1?Q?uAfyp5kYIgWh4y4vnzpQZf3CpN9jOyMOe/CCfzJeKZd66eC6oEJWhgceX3?=
 =?iso-8859-1?Q?iUwh7cPKRTwRpD5JmHk5+vvHZVjqBmJEyrYG9zzlZ1iJb7VvmgC13YF/bl?=
 =?iso-8859-1?Q?7sA1e5iVe8OF00bDuzU5QuGv0IiHM1lazGD3X/y4F71fO46nD06dMVQ5w+?=
 =?iso-8859-1?Q?7skfoJO85SYnwF7adYSlp5DKX6vcSb0yUiH8SBRy55ggDbLN+WWXnJTZ9I?=
 =?iso-8859-1?Q?grD3C6+nVEhCU0Vo8uY4byZtlZsL7x1gUHqKO9azFVCcOg3RKGV2ElJhp8?=
 =?iso-8859-1?Q?ku9sbGLlSJ8iysczGFrSFT++A89lLkGCLPGPTTsAW24qCLAZSIh/n7H+Hg?=
 =?iso-8859-1?Q?yaVrv8u8N/6OcsI7ldQLpdRcNcqSXkY425H8VGdbBI0o14yalwvUjx+mWU?=
 =?iso-8859-1?Q?Nz/6svS0UgtJpQKatW9L7/avp7r6eQ3kpfT2mbTSB2OmFdPA9MZAZATNsZ?=
 =?iso-8859-1?Q?WMBOj5rWCEZsTx4Ic0GbsVykNj7CFnxp4r0BtU0sEaKWt+L5K89GmjJ2bQ?=
 =?iso-8859-1?Q?scdQFrSCq3mIakKC0F8HdtTGfAOZD7aKVzmbCtoh0nbbMQ94RF1zZcyEY4?=
 =?iso-8859-1?Q?mrAXhNCP/fdISxxTZmVX4+3V94kz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bZBMcIDW1dSp142XcG8SJD9NyIdRlol0CL/Zeu+w1m8YL+1SrOv6aAZ0yH?=
 =?iso-8859-1?Q?bfQiVVqYw3jd+OWaIbqNSf2qHnqf6ENzit3Eh7PTmUIhBH+XSan4CzIXYW?=
 =?iso-8859-1?Q?bL0fYudKoAa0rbf7RKUO3r8hV8F6V3A6yoB5iiJvc2txRx9IA6TaU5++OD?=
 =?iso-8859-1?Q?gIV/JUKwE2Gf8y8q5Tqy1wSs7/TFuBBYzw4JjHAIbVgnrXf4W9i+6ePlaq?=
 =?iso-8859-1?Q?nZEZ3lmyca0H2VzOgr+97Aa6/08nUG6xfFZVX7B9Krk+zppFyk9Kh17UCL?=
 =?iso-8859-1?Q?HnkYKkechLazTwya32JzRIP//H9/oK24V0YJfBWrXiLspi3Ag3qq/oyhEw?=
 =?iso-8859-1?Q?nsjzaabNe6lYD3XBa1D/OkGa0jhfP8mcd+PJ/bHhStea+mh7KvJB89mTSE?=
 =?iso-8859-1?Q?QSBBTWIiMBqap18oal9yiYqMucG/kMi2hOqAu/hZLS1SObvJtThPTvRpR3?=
 =?iso-8859-1?Q?9OgonjMgrvt7Blf/lEMg6tjHcaLiNLbWZ1fk6DI4pRHE9jVzD86/c8Q0yl?=
 =?iso-8859-1?Q?YTKa9l8kBfXhiq2GrruiOgeKlActZuvCQSP+JGuT20tkizhhkeJV2vnoX9?=
 =?iso-8859-1?Q?SD86eJBmecBOc2TsQj2KYN2p1GA0YMiWA/3t3urR826F4eYkRx5jqBu6uG?=
 =?iso-8859-1?Q?yB4/OQ3Fj8PfMrK8BNZQkV6EGeTZAnf4sHcVOuN8/NPq/2E6m7WCWx7cdw?=
 =?iso-8859-1?Q?/AFAVLB35wGByOZqYDS2Y9IVkFtkLPrvMk7q0rPn3GzaJplamCkE8e9svl?=
 =?iso-8859-1?Q?4Sgb1dJr82JenjVy0oeYoHhsWdVcaNpXyTA1Hrvi7mNIzhMuDnO9BOmqbK?=
 =?iso-8859-1?Q?3wGhs4HQyOtCj279Tx8ipNU3/XYdpOZDIYq5SDfFWwN1z4hCC8+AbJ1P3N?=
 =?iso-8859-1?Q?WOqv6Fl2ryPqpUZbcmaT8fFT0p+EeoYrLLVtjQAX79gZKiDBFu5eQs3FhS?=
 =?iso-8859-1?Q?ExJK1HKowjOJp8BdwTYy7JdQX+9Yy813ySOYT5+ona6JcyshMdZXz2zzOB?=
 =?iso-8859-1?Q?R6AvLpSyoidak2L2E9E7W0mchRzNqxtaTUM0MR3y+GTrG6nizkxR+H/AwB?=
 =?iso-8859-1?Q?oeBakcINaXVWVj2ZwYNsDLadMVwtlChaB+GXYOGqUXPNWHtrwpDY4KtWay?=
 =?iso-8859-1?Q?e8N1l0XUY/uVrsxzVa2GSe9QpO0J3zIKclEa7OL8mJXQ4QdGfS+rI2EdJ7?=
 =?iso-8859-1?Q?cfayKN6aR5K+NvmxTVcFzPI/g/QK3o+UIOvuGGt0k3bXEvKqBsrrHCxd7j?=
 =?iso-8859-1?Q?oEDJObUVP5sQ6sPwdiPSRXABZwNzbt1lqj8Jh52a4btQquN+93afp07WmB?=
 =?iso-8859-1?Q?O6BrGHA8MAxTcrLV8rznjEHqsFBpPfAoyij7ppmSIu+muwa1n0a8mwkBHm?=
 =?iso-8859-1?Q?9JaIlYskgdMNcNIdsCQfnfoRickZzbnuxqtcNmQ3RwO9emRv/P31wojXKx?=
 =?iso-8859-1?Q?ihIXWpkfcpJ59IaAm6zHmetNRQEUpzCRJ/cuxbpwfvNutFBiNWxfp+9Men?=
 =?iso-8859-1?Q?XWjeKJnfHh7xjk80twY4+ljv2+jDD9PTxGpcP0FWCE8NZsn18LHoBIwVA4?=
 =?iso-8859-1?Q?S3YB6ylclHcJHZXCdiCRNOLgmwzfoRn/rgAIcYguAhGEgVEejVpMrhaw8z?=
 =?iso-8859-1?Q?muvuXIM+feFI0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 866789fb-40fb-4d37-eb7e-08de034cd55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 13:49:26.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Z8hystgE05AIPHgarzzWMmu0BVHAKSMC0FP2ARhx7o7oyFxfF03xx8sa6y9Kdz3FmbrCEmgLwaWDUepxtFBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

> ________________________________________=0A=
> From: Gregory Price <gourry@gourry.net>=0A=
> Sent: Friday, October 3, 2025 9:23 AM=0A=
> To: Vishal Aslot=0A=
> Cc: Dave Jiang; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vish=
al Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; =
Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>=0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
> On Fri, Oct 03, 2025 at 01:03:16AM +0000, Vishal Aslot wrote:=0A=
>> > ________________________________________=0A=
>> > From: Dave Jiang <dave.jiang@intel.com>=0A=
>> > Sent: Thursday, October 2, 2025 10:32 AM=0A=
>> > To: Gregory Price; Vishal Aslot=0A=
>> > Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma;=
 Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu;=
 linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
>> > Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>> >=0A=
>> > External email: Use caution opening links or attachments=0A=
>> >=0A=
>> >=0A=
>> > On 10/1/25 10:48 PM, Gregory Price wrote:=0A=
>> >> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:=0A=
>> >>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hd=
m *cxlhdm,=0A=
>> >>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm,=
 i,=0A=
>> >>>                                       &dpa_base, info);=0A=
>> >>>                 if (rc) {=0A=
>> >>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>> >>> +                               put_device(&cxld->dev);=0A=
>> >>> +                               rc =3D 0;=0A=
>> >>> +                               continue;=0A=
>> >>> +                       }=0A=
>> >>=0A=
>> >> How do you suggest actually testing this? I briefly poked at this in=
=0A=
>> >> QEMU trying to commit decoders, but i found myself incapable of=0A=
>> >> exercising this path.=0A=
>>=0A=
>> I tested it locally with our BIOS (UEFI) where we commit and lock all de=
coders and=0A=
>> all except decoder 0 are zero-sized.=0A=
>>=0A=
>=0A=
> Ahhh, so are you saying that you will only ever observe the following=0A=
> (as an example)=0A=
>=0A=
> endpoint decoders...=0A=
> decoder2.0   ->  available and can be programmed=0A=
> decoder2.1   ->  size=3D0, locked=0A=
> ...=0A=
> decoder2.N   ->  size=3D0, locked=0A=
>=0A=
> or are you suggesting the following is valid:=0A=
>=0A=
> decoder2.0   ->  size=3D0, locked=0A=
> decoder2.1   ->  available and can be programmed=0A=
> ...=0A=
> decoder2.N   ->  available and can be programmed=0A=
>=0A=
> ~Gregory=0A=
=0A=
The first case is what we've got. In our case, the HB has 4 decoders. The e=
nd point (a Montage card with single port) has two decoders. For both, we c=
ommit & lock all decoders and all decoders except decoder<port>.0 are zero-=
sized.=0A=
