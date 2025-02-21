Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92535979
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114921; cv=fail; b=ZbvspIlMs4ztealOXX/t0vQDuWn3HT6s2iWP3MN61mssDy2hTovs9Qt4vYV6gX4Uh5ETGaAd5KFFymiDC/4vS+j+Irw/QWRSvatULmx0Ds1LvsB1V7KKzplEcttlwiTkz68E10GKW+rFPgk6icdE7tJhwmAVaRBRwFAxwQYYOxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114921; c=relaxed/simple;
	bh=Z3BaUo1B4ne7WW34QB2ifXv0cEsUl4Img1RlMqeWJQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBJ96Gtp2Fn7mejwcu+tLukMjTG7/AHsdPnUCkvvuTBEn4HSh/MIfEG75S7edyPFvZdajGVydrbnOP/tGulq9Ja8f3OVISBPwJduj5sUy3NJ/oa8V3YrRfTbwM28jOBows/s9EtSPsxVgnbcdPRKG3jQ1k2ZIBaW0fmrPh3kSQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtN4+EO+; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtN4+EO+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToOphrUkDKn7zGufz2GXd9C7jZ7gVmSexNKIHx1RIm2TMg2VMuGqmDQeXbkdBXPxfmylNvUOxkD9UHa2xTmEO4yAyN23BL/bpYmL00SKULii/Ky7RlImDau1nDpp+vyJEFHXds7i6A6ff9Z6q68DVwTWFkaHr0jqClZzDv8s8eIfb8IpijgswZqM+S5QMnHmIHZqqzrL+JzFI10ZguK3S5omM16DicALTUKfPHW5HIO4ksRsWRz1cYv6kMIsxIFpbJUrYU9b8VIaTE1yDviJp/hI4HxmYGxOutSOawn4PHMKArbWlM3uEN+0vZT03+mE6Izc5ffwwndanElI5cjbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA7rzwAR69/LWGs1t2u8mAbAVEEFYhVJ6ZlgmqE0KkM=;
 b=aj6oIqVhaSklpKVljYGrd6u4oUeIreUN1SPQnMYjbMcgzbn1yjfiZ92ON/ZS3seGTF2D8xE4PvnV0OqOghxum6OVifp339AJAW19w8xIJex22X+g2rWVDATLy2Etv1uy2LpOeiT5YHgpGTD+AdaYM87K071Ds7mWUMQiEgpqVw9BIR4b+zPNidvECPeHhG0AR8f6p1XsDRQoH3AHgo2ahXYpTltRmzEDGtqAO4JqfCdeDSp6GSFjfbap9WUrG1EhYWpJLS5m/ZSgxc/hQ85zWFwa9asj+y+/TT5uc754lsTVKKepd3MtjXVG9zbkpIgWBJ1aBcPfnTc/l0MvbEXhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA7rzwAR69/LWGs1t2u8mAbAVEEFYhVJ6ZlgmqE0KkM=;
 b=dtN4+EO+TuvcQmn4f8ghJd5LoyzepMGJSo46hwM2US+th65c8KXudFcuBhHTfzirBOTNgbYYQ6XphbB/Bk+u2z+6pmK03hXTkMDATV3dc4u6OMerMa+Ir5/RmMCNcCZXnjI5wfTgfxceX7dTf5G6BgcycWCNenLMAsydtozBnNYlDMR4jfn9hY7LAL8IFskDildUvareMq9ANupFVu3t/xbe7ehrz7oIN2nLW23Od2v+9XMQL9E/r3l+4ji4GWz50t0cF2SurBePOgLa/RR8eutLxRUg4FQNoXUOCttb58SjTerzF5DJ7SXBDsiyPj3OjafqvXb6J9F1Z6tCXlWAfg==
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 05:15:16 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%3]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 05:15:16 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>, Vishal Aslot
	<vaslot@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
Thread-Topic: [PATCH v1 1/1] cxl: add support for cxl reset
Thread-Index: AQHbeT866Aw7Tg8YnUuaiXuiaRS3l7NHEHmAgAo7dZo=
Date: Fri, 21 Feb 2025 05:15:15 +0000
Message-ID:
 <SJ2PR12MB7963FC11EBA1F83692B2E887C3C72@SJ2PR12MB7963.namprd12.prod.outlook.com>
References: <20250207090327.172478-1-smadhavan@nvidia.com>
	<20250207090327.172478-2-smadhavan@nvidia.com>
 <20250214165709.00002008@huawei.com>
In-Reply-To: <20250214165709.00002008@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7963:EE_|PH7PR12MB6834:EE_
x-ms-office365-filtering-correlation-id: 69002c18-b42f-4d1a-d904-08dd5236ba11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3xFnPzYJrCZZzB1OKs25I/rFho+5jT08/9uBsuiIwQLoUikMFXfJ8b2PR3zd?=
 =?us-ascii?Q?sFfS2w+KzRr2RYAmfyUgwO0lktfy9wP6XRT08ZgpRynwd8d2Ai38V3pQfWcC?=
 =?us-ascii?Q?k/CHx9+Zknah64f1Km3YJfv3DiR0SHzPefpA8Cpy2uhh0ISKjpsup1w56dvd?=
 =?us-ascii?Q?9SHisKSRCYBlSAguBvxGz3WUTvkVF4A0QLTiL6Su+C6WofyS/0BLnAhoeu4+?=
 =?us-ascii?Q?ZzRzObn4FCV7a8m7d94tyQ+hwNsBF4kp9tdcrpwh4t66GeZvtGf2W7YsItDU?=
 =?us-ascii?Q?sOCasWwH1nAhwiESIcb9WrafV0+T9+pZ+50i/BroDcigbHEI0Q0dNRMMBOZO?=
 =?us-ascii?Q?qQFUxWDUnPIimKj5DAzmBUsAe0gyvnnuHPoifuC+DvtXrznHiC7nthKAWuZw?=
 =?us-ascii?Q?OEf+1DkqdVxrs/8WTRbco3Iz9/B0pGWenGN7FVn7rZW0LiOQOmI47jcfnbGe?=
 =?us-ascii?Q?cFW4DtIx7hbDPvBIS56uvbS9OJsMhVblNjm4ZgL+4cgscSjeVwdtxHl1ZR2m?=
 =?us-ascii?Q?px2qnLjkh+Z2MiSTDuLO27OPwR2Yxk6ZDXTyAeCyI0/x/DO+ew/TPiGFuB9L?=
 =?us-ascii?Q?sl7AY9OyoUFqh03kB5/KfwsSiTUg0uo1RDn181yUrvmIkodV7TWawY+rqbGv?=
 =?us-ascii?Q?tj20cVzK70tc6QA2KGjN4uxHV13tCNKYcX+d/gA30WqMNBaLlpJzsIGcBqIV?=
 =?us-ascii?Q?5W/lZXA+qFkfN3DizDhHMCHxGBIq+XXMTv5lrRmBUpMGhFPLX2k9qD6taqSW?=
 =?us-ascii?Q?5ejgpvbZ5Sf7C8V5DJGDSGOjf3kug18ppkcLYq3MdHXygxb+HymKxVrCG0oQ?=
 =?us-ascii?Q?b5FZMtPHricnTAU4frl1d5YzulIRJwhrvTLZZrkyFQceC6JhN0/FNklzVo2q?=
 =?us-ascii?Q?jB559BYhpFVmUG4Rhu9npj3vSI1F9099TIVXvDkf7IC8Zm6I7zlTYZvH7Ge5?=
 =?us-ascii?Q?V3O7JP30OZEXxmgCS/F/l/JLUTvVzLxctDBFbzcndHz73r2dVA+JbHfjMKzo?=
 =?us-ascii?Q?Zapzli+Enoz79514th0TO09rKO9uB3sdpjMPUtYKrcSNAo4jQ9TNaU25Rm5n?=
 =?us-ascii?Q?x1ZHBd4oobVVo65qdyBZiuKWLSY993Jz/rwTE41Z13nFxuF6mR3Q1D8t43Dj?=
 =?us-ascii?Q?na0Ra52ft7gpe6NowGsdNEEG0gipLCBcoTtAB6/vDUZggmB2Vn8oZvDCqRq0?=
 =?us-ascii?Q?xiCnBhfRlYJA182Bl4KDalb9r1VXXit5JY444rCiodN5CyYjxaYM4s45dI//?=
 =?us-ascii?Q?eLMCFTTL6sm9dhSqfgXBq4+en40IHz8tov0bvAK3hdBTR70zHyvEojr4ijG1?=
 =?us-ascii?Q?BzUAjKt1ugLMEoY/p8bxySIibjIKMmaLr4IYlF5OGQ6ukCvz3ACqdCAdJV+y?=
 =?us-ascii?Q?CIaqD7yH03DAsDTDaTuq/U0NutxKCF7YfPVHRjyy2tpiWxgD+/sWCpl/lywF?=
 =?us-ascii?Q?d8TKC58gqqSJYmqrFMqLQnwg73AKF+KZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nHL2SXw6gZ7Ubs+ZLa5RNo1Ed19A2L3GDqv4arImq/7uuuRLY7FLXfL7aFU/?=
 =?us-ascii?Q?Gi1Pd8PIsIVqXkTaqOzy4vpbVuOoQ81aXcCnugHQTIC7TuXO5ibBZO1OQkbM?=
 =?us-ascii?Q?Ys4U6ZEFwmZvKR6T0j9OvBDY3OPoyAyT8OufxQl97NJN/dOYCgyQOB9j0Zo0?=
 =?us-ascii?Q?lnPEYWUhMOBvLumrZA7KmJKQyenJlYXzTerz+xp/pKIyh+uDhU3+g0Wmg2cS?=
 =?us-ascii?Q?x/68+0MA8FqTpsqHe31XELe+3flecnE615oh9m3VGyMcQM5rsSW6yMPBgSbr?=
 =?us-ascii?Q?bCQN6QyNFb92dWua5M+CnAGhXPdpheO/xyZXpWF0KuDn7Z+4L+4pmJiZZA4M?=
 =?us-ascii?Q?lk/Jv1PHfbjhqYyJ/cPPDL1/RuRqu+TqF4tUCyO8+0LrWVILMKhMMCrP3c4t?=
 =?us-ascii?Q?Lmee12WeoHuh76ajrMdTW4iUzYkC9+FLrAgmcxQgxxwe91w1/G90cJW8dH7y?=
 =?us-ascii?Q?T5Do/yb1MXLz1YIjJ6k6ZAJ0X0IGsaZHrHqbhjw8lLFdTkCsYz2PlkoWMUEC?=
 =?us-ascii?Q?yrarmerBOhDPjUf56VerzsM2ZJPs+l+etLaUVfkPBrVQnyqFWq6uE6MSxS6f?=
 =?us-ascii?Q?jC+Kz7/1zsCvQwkJMrEVL97zZdDi/SADCDiMtA69iHit3x8o6JNdCeroEjNz?=
 =?us-ascii?Q?8h0eUKm0ukID6xf+TBSZcnDPiCAyVjzvQA6DXKEDV5mYFvGwxvowIwFZbtVO?=
 =?us-ascii?Q?1BC3cZvll/xa3nVDLXxacLSPdclx+BUAvO2mQmw41QiHW9wqIWXY+WB9g85r?=
 =?us-ascii?Q?YCCWUDmykW5jSoO9lDJlq5ez5puuxuXVCU1kGcUKzd5ctPvxAldS6iKdRVo9?=
 =?us-ascii?Q?BtG7443Epz1isb6HQ84ZACtBWQshticJmWlIq7620HnuDgjzoCPZiGj02oEc?=
 =?us-ascii?Q?IvKJTxeA4egrlg5a4UZIKdpMmeBhJ9VaPRSeM6XLEyNqanlN+6lcj38OW3k9?=
 =?us-ascii?Q?C85hcfl/+UjfY0G3gkpyiFp/pwgIKdQx7jU0v+Vj6QCHmWRwf0SjO5wXYGIT?=
 =?us-ascii?Q?qReuRmrBkH9ckS8ntBw9saKh3FLAcGTmrQu3zttWogGJHoZOwqMdBHTncb+y?=
 =?us-ascii?Q?tbAIioKx0DplzKbFY38dXf59SV27N8pTMCIuJ9DE+5sGcYgmR60K4H46x2wj?=
 =?us-ascii?Q?uqHiD6ZUmFB+XGNEip76zvLGTf6yccX4YiIouFUlF4UuxVAZ9c8tEffov5fD?=
 =?us-ascii?Q?3hJfpoqDf5cIZSdyX2mWZqZohx7A9eBhYaTJcTPQhwfdJavT4zgxBhyOpWcK?=
 =?us-ascii?Q?czdG4hM/0X04yG1gs4GKVVjyr4120W2y6lIA+w0fScmiyzZvRkcdHPLOyz8D?=
 =?us-ascii?Q?PkyK9gEhkrXLIIaIYyEBrHvX5e+wJ3ShuNrE+T9eDXXOIFNpDXk8DIp03Rhv?=
 =?us-ascii?Q?CrscjSGBzyuCFkBB7Ull/j/1/AL45RB6gmyTEy9uLWSYxVT6oNok2ckbDeVG?=
 =?us-ascii?Q?SIVNCr/DH8ZvIc5OGhixm6Be3/HRc/R8M2YQh3uYKTGyvymCzzesrCOqXoBo?=
 =?us-ascii?Q?gk0C8SpOE4Cu4gifr4UaIjhdh2ojnb0OWTPKWxbAjlrQiHR80cxOWniltiSH?=
 =?us-ascii?Q?7U8A7gR7T7nXAqBrqmy+VyZuATNHi1Zf2fHRwFnO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69002c18-b42f-4d1a-d904-08dd5236ba11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 05:15:15.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iR9qVrHo7ZQlff9ak1b5msBXpMb71DxVc2PM5e9o7KgU9htzA5PnQ/RC0eEV5gvRUilAlsyd+pyCr5etfGfVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

Thank you Jonathan, Ira & DJ.
I've addressed the comments and sent out v2.

> We need to deduplicate the stuff in here and drivers/cxl/cxlpci.h
> as CXL_DVSEC_PCIE_DEVICE
>
> I have not complaints about promoting this if it is going to be used
> by PCI core code, but I don't want to see two lots of definitions
> for the same registers. Given there are a lot of renames
> etc, do that as a precursor patch.

I've borrowed the changes that Alejandro's T2 support patches made
and moved them to a common header to remove dupication.

Regards,
Srirangan.

________________________________________
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sent: Friday, February 14, 2025 8:57 AM
To: Srirangan Madhavan
Cc: Davidlohr Bueso; Dave Jiang; Alison Schofield; Vishal Verma; Ira Weiny;=
 Dan Williams; Zhi Wang; Vishal Aslot; Shanker Donthineni; linux-cxl@vger.k=
ernel.org
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset

External email: Use caution opening links or attachments


On Fri, 7 Feb 2025 01:03:27 -0800
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> This change adds the support and implements the CXL reset
> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.
>
> With support for Type 2 devices being introduced, more devices will
> require finer-grained reset mechanisms beyond bus-wide reset methods.
>
> This change defines the necessary CXL DVSEC register macros.
> For devices that support CXL Reset, cache lines are disabled, WB+I is
> asserted, wait for cache invalid status, Mem Clr bit is asserted and
> finally reset is initiated.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Hi Sriranagan,

Various style related comments inline.  My main suggestion is
to match local style of the file you are editing where possible.
Also look for duplication of defines etc.

I haven't checked the spec for precise sequence but will
do that on a v2 once the more superficial stuff is tidied up.

Thanks,

Jonathan


> ---
>  drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  25 +++++
>  3 files changed, 209 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..cf6009f5bd6c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,12 @@ static int pci_dev_reset_slot_function(struct pci_=
dev *dev, bool probe)
>       return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>
> +static u16 cxl_device_dvsec(struct pci_dev *dev)
> +{
> +     return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +                                      PCI_DVSEC_CXL_DEV);
> +}
> +
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>       return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> @@ -5116,6 +5122,182 @@ static int cxl_reset_bus_function(struct pci_dev =
*dev, bool probe)
>       return rc;
>  }
>
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
> +{
> +     u16 reg, val, cap;
> +     int rc;
> +     u32 timeout_us =3D 100, timeout_tot_us =3D 10000;
File seems to at least at first glance use reverse xmas tree.
So do that here as well.

> +
> +     /*
> +      * Wait for any pending transactions.
> +      * Assuming this does cxl.io stuff.
> +      */
> +     if (!pci_wait_for_pending_transaction(dev))
> +             pci_err(dev, "timed out waiting for pending transaction; pe=
rforming cxl reset anyway\n");
> +
> +     /*
> +      * Disable caching and then write back and invalidate lines.
> +      */

Single line comment.

> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +                               &cap);
One line. It is under 80 chars anyway.

> +     if (rc)
> +             return rc;
> +
> +     if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
> +             return 0;
> +
> +     /*
> +      * Disable cache.
> +      * WB and invalidate cahce if capability is advertised.

cache

> +      */
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                               &reg);

One line. It fits I think.

> +     if (rc)
> +             return rc;
> +     val =3D reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;

I'd do this in place in reg.

> +
> +     if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
> +             val =3D reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDAT=
E;

I think intent is keep disable caching set for this one?
If not use an else to make that clear.

> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                           val);

Single line.  Check all the code for this.


> +
> +     /*
> +      * From Section 9.6: "Software may leverage the cache size reported=
 in
> +      * the DVSEC CXL Capability2 register to compute a suitable timeout
> +      * value".
> +      * Given there is no conversion factor for cache size -> timeout,
> +      * setting timer for default 10ms.
> +      */
> +     do {
> +             if (timeout_tot_us < 0)
> +                     return -ETIMEDOUT;
> +             usleep_range(timeout_us, timeout_us+1);

Spaces around +

> +             timeout_tot_us -=3D timeout_us;
> +             rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVC=
TL2,
> +                                       &reg);
> +             if (rc)
> +                     return rc;
> +     } while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
> +
> +     return 0;
> +}
> +
> +/**
> + * cxl_reset_init - initiate a cxl reset
> + * @dev: device to reset
> + *
> + * Initiate a cxl reset.
> + */
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
> +{
> +     u16 reg, val;
> +     u32 timeout_ms;
> +     int rc;
> +     u32 reset_timeouts_ms[] =3D {10, 100, 1000, 10000, 100000};
Local style is reverse xmas and spaces after { and before } in lines
like this (well the one I could find anyway).

> +
> +     /*
> +      * Check if CXL Reset MEM CLR is supported.
> +      */
Single line comment is fine.

> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +                               &reg);
> +     if (rc)
> +             return rc;
> +
> +     if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
> +             rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVC=
TL2,
> +                                       &reg);
> +             if (rc)
> +                     return rc;
> +
> +             val =3D reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
> +             pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                                   val);
> +     }
> +
> +     /*
> +      * Read timeout value
> +      */

Single line comment.

> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +                               &reg);
> +     if (rc)
> +             return rc;
> +     timeout_ms =3D reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL=
_RST_TIMEOUT_MASK, reg)];

Rather long line. I'd be tempted to use a local variable for the FIELD_GET(=
)

> +
> +     /*
> +      * Write reset config
Single line comment.
> +      */
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                               &reg);
> +     if (rc)
> +             return rc;
> +
> +     val =3D reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                           val);
> +
> +     /*
> +      *  Wait till timeout and then check reset status is complete.
Extra space before W and I think fits on single line anyway.
> +      */
> +     msleep(timeout_ms);
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
> +                               &reg);
> +     if (rc)
> +             return rc;
> +     if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
> +         ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
> +             return -ETIMEDOUT;
> +
> +     /*
> +      * Revert cashing disable.
> +      */
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                               &reg);
> +     if (rc)
> +             return rc;
> +     val =3D (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +                           val);
> +
> +     return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +     u16 dvsec, reg;
> +     int rc;
> +
> +     dvsec =3D cxl_device_dvsec(dev);
> +     if (!dvsec)
> +             return -ENOTTY;
> +
> +     /*
> +      * Check if CXL Reset is supported.
> +      */

        /* Check if CXL Reset is supported. */

> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +                               &reg);

One line. It is under 80 chars.

> +     if (rc)
> +             return -ENOTTY;
> +
> +     if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))

Using ~ for a single bit is unusual. I'd go with

if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST =3D=3D 0)
or !(reg & ...)



> +             return -ENOTTY;
> +
> +     if (probe)
> +             return 0;
> +
> +     rc =3D cxl_reset_prepare(dev, dvsec);
> +     if (rc)
> +             return rc;
> +
> +     return cxl_reset_init(dev, dvsec);
> +}

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..efcb06598f26 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>                              PCI_STATUS_PARITY)
>
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c *=
/
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>
>  #define PCI_RESET_PROBE              true
>  #define PCI_RESET_DO_RESET   false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 3445c4970e4d..52618c5b095d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1209,6 +1209,31 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX    0xff000000
>
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +#define PCI_DVSEC_CXL_DEV                            0

We need to deduplicate the stuff in here and drivers/cxl/cxlpci.h
as CXL_DVSEC_PCIE_DEVICE

I have not complaints about promoting this if it is going to be used
by PCI core code, but I don't want to see two lots of definitions
for the same registers. Given there are a lot of renames
etc, do that as a precursor patch.



> +#define PCI_DVSEC_CXL_DEVCAP                         0x0a
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE           0x00000001
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE     0x00000040
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST                 0x00000080
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_IND     0x8
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK    0x00000700
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR         0x00000800
> +#define PCI_DVSEC_CXL_DEVCTL                         0x0c
> +#define PCI_DVSEC_CXL_DEVCTL2                                0x10
> +#define PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING                0x1
> +#define PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE       0x2
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST           0x4
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE 0x8
> +#define PCI_DVSEC_CXL_DEVSTATUS2                     0x12
> +#define PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID               0x1
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE                0x2
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR             0x4
> +#define PCI_DVSEC_CXL_DEVCAP2                                0x16
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT                0x0000000F
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_0              0x0
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_1              0x40
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_2              0x400
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE(x)          (((x) & 0x0000FF00)=
 >> 8)
> +
>  #define PCI_DVSEC_CXL_PORT                           3
>  #define PCI_DVSEC_CXL_PORT_CTL                               0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR            0x00000001

