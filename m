Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBD281525;
	Wed, 18 Mar 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857239; cv=fail; b=kByqtCnBQRGuoRbsNzn2mFeHKlGh1ZRZuYD9DddkaN0CsR0Vr26XPKyxrJrWqZATm9DVJuW22Xz3WpXwOALjvywkwJGMhHu1EcuxuNIjrb056ZjP4ZDdJNEGHbcJgD7o+Z+5ivWGz3m+J04i+OL3FzxzUY8/oHTfJHf5LPW/Gqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857239; c=relaxed/simple;
	bh=f6TZqQ9XnucdxQ0rxGHq2aLyFCKIq3D4OGl+FxApToo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+JNABIDoazY7yNB+ktG2KuT8uTna+/NlKjoMJIg/40dp8gZ2+lLBMlc1to6PvP1/JJ9HjzfUTGlvZDtrg6NJOvqBmDH76z+Yw8haZlCsOhX6ZdlnyfzILn3WB5UqmXd6pdwwCFq8DYz0kni1vv8XHN0IZztYdl5XLrL8v93/rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTuQvvAr; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTuQvvAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw/eLb7M2tg2ICrHxIHLpEX95DYWBIgIWW/kxi+2kgZjsM/56XUBJPT3BnPUfWWQS3JmwH9Jhgwt3Hy8vlm4RIMP8Aff/D98CtKmsJUwrB9JE36yw7nc9vtb0Ueh6pfH/bjbJXTD18dz2eq7kx1XYOBoLukbk5jBKc588wy0sLrK2NWdDoAj3yJKOKC35L/cBL/HFkjf4j/2S84VrZDZjHQ3pFm5G1X9sU5/RwlWSc9r+w9qlKGQ7hSxDxAENSDw1MNossXrQEy9YK7VfmCNlkykcEcYSi54VkkrSa/XOOnrAZ4HhQUY1bgD9DMeERyiLvrweHVz40UTr1m4cz1ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6TZqQ9XnucdxQ0rxGHq2aLyFCKIq3D4OGl+FxApToo=;
 b=ku12OZUo8oQU+pxgJ9Sh82l3xEg3jOEOZ6OznZbSnuWGC4OwtQl7lk2tZzyJC0pSinoL0JpNYrVd3LyGMrIxpUKsurtMiPIZDvDf0m2HFzVpZ6G4gnHfNPgRji3B/xdikCBCmf3plOh8/YDyWTVasz/oSEVANuVVg9++LPAxd3AVpQvul3StK6QytUijkaefM4w+kx9p+PULeWxY5s+Bhz4J60DOgcOrmFRvZT1WnVd7dlcb8/BQM0TJxATeLnMsnsr+4tmB0nisbL8oAybn39diz57D2UA6sv6SDEMvLQKX73yc3zkX95hDfdIefNoLCkVCANZG2KZ/CDTDIyamlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6TZqQ9XnucdxQ0rxGHq2aLyFCKIq3D4OGl+FxApToo=;
 b=pTuQvvAroDcpCQHj4ElTpLNum/qqZNkwO2bGbsfrL70cO3P7gXAg243G4iDrhgYSuHqCU80NcluTspSEn8n81Uu+FkmI4dzm7hypLR+vCnPoMtnyXKaSIJf/J0TeGtC8lU0qGukSqVR5yYpCG0/qaBwQRoO4Yl1ne54gTPliGcN2TPXL9RigdjkelQCjYDo3j1qJuXmBAacFIqWYcqSL800mrVaaNixNFvUSbu0KNn6YDOQtAaDnPtotGNJK7WWsj5DCGfCl+eyjYY/waBgMd/iO0n53EfBjYzLY3uC9aBPMIze7S/6jdFIbEmlZsVrwG3XeZpVoByMDVDQoYUeE3w==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:07:12 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 18:07:09 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Aniket Agashe <aniketa@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>
CC: Neo Jia <cjia@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 20/20] selftests/vfio: Fix VLA initialisation in
 vfio_pci_irq_set()
Thread-Topic: [PATCH 20/20] selftests/vfio: Fix VLA initialisation in
 vfio_pci_irq_set()
Thread-Index: AQHcsZb0SGPlpefL70uIT+UjXZe7fLWtDPOAgAeTorA=
Date: Wed, 18 Mar 2026 18:07:09 +0000
Message-ID:
 <IA1PR12MB9030A3B113EB9E4A03AEC6F5BD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-21-mhonap@nvidia.com>
 <ca0b9c17-8b3b-4460-be5c-26139341ec6e@intel.com>
In-Reply-To: <ca0b9c17-8b3b-4460-be5c-26139341ec6e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SA3PR12MB9129:EE_
x-ms-office365-filtering-correlation-id: da2a5948-efd5-445a-c3a5-08de85192c62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info:
 qnwFzxZD7UNSahlMgVQeATqxcDR7ZiVVd2wnQ2v5EhhnaJvpkA1kEr2XJqW8vBkSH0QC29fAuJRV8qzwf0YvwOb9I76uRTlFLq6FszFXrl5S8nBNcwL8LHjB2n8BOjS75xKt/5h68dI1FSjEpGyUasvU6x9GMEz+mUmHDpAbeRkBFdLqumIfDajKT7MKzg+jfHY8RNfb2F/ATnDoTv1ZHnA8gnX5qkZYyYLg4C3KnkZ9K3kUC9OfIQc5OtBPD0Ro4gi2666ESvahs16dYHQBu/gLOjcHZxnxoT6SyE9GaHs2wBQc1cyjktl5qik21XBm6jlFqCPN5B5+mGabC0SHmXfbJnWLziwBwSJvkTxbxqytcH7bvWRFzhwmMLTSXsC2fq6XYDmFyi/RBKK5xGErWxKx9vp52UDYNXO6GeKVviUPK9jcWHQjv+rV9CMyhjtdY04N8qTz1pjSIqN6pzJdWphOC2/QIn0Tg1s+/QTMsZ7PkVUHAs57dM8Ia+QZKVg8blEybY+a9/9f9jmYz/jNJOvYeaDy0XfWOUJQEiPBk83O4yhP6tRNI0XaVYp1PWA+pOuRS80+nCuo0fO4VCGmu5NUWhoSrV3kSRcpdp9LM6dKawZaTEHlwhzI6a6J6/bGntDdxRZsYzhKvkTqkdoTi5Wx/CGFTbFxjT6oVxVeL4dXUASgOaNBI46265vcsnLaQW+IwqlzlnbG6jLQx1g/9DnCzkyhMQttzizRGNmnhpEmjNpaMrRIFR1aBYu0l9M9VAPBqj8GgdAXZVobs9Yftjgtl1auFTeYE+2V1JlqD2zuBJHNM9CDQofIeDK/8Q7y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0dFQ21iM0UxYmRLdGRnSFB0MnZRL1hPNExvVk1Ic0NGNUZQT20zdE1YQktJ?=
 =?utf-8?B?c2lMMmdWUURwZ2hkeUprOUVCcFdkWVVNWis4SDJhS3B5MnZpSzcxYkhNaXVt?=
 =?utf-8?B?UUViWXRGdnhyNlFZYjVpcmdUVmhoY2l5SnNnRjdHRStvczhZZk1iczZYNnhh?=
 =?utf-8?B?ekxZN25uTE5wTk5MVjF0eG56dG1JQ0YwK01NeGxUTjVXUmxkaTc1NTRHWEov?=
 =?utf-8?B?QVBhbDVxUUx4TFN4WTJmM2RBdTF6cC84STkzSG1yRS9IS0NsRXJjK0hmS1B6?=
 =?utf-8?B?dENQNFk4VHQ0dTdrUkdHVHVNaUdoallSbWJBbjBKTmxyYXJlam5pMkJORUls?=
 =?utf-8?B?d2psdnAvaFNiZWM3aEkvMk1KUVpzenFjdWUwS3pkejZjRVUyVU1uL1ZWZm12?=
 =?utf-8?B?Y2JoVzNnVDJsQ0tOSFBoRStkMWE4U25ENkJNTVl6NVlkREkxUUZPaEZRbWp4?=
 =?utf-8?B?TmlCWngycEJtRlErOHdqMVV4bUVVV2xOc0NTN0dhU1R4bWdJV1BURktGNG1r?=
 =?utf-8?B?MkJxSWNNRDMrS1pteUQ2MHF5SnM1S1lhSlEySGdvSVNYVnZNRmlLSjJSUEJw?=
 =?utf-8?B?SmhyVmZYc1pwaWZPdEIwc25lSUF5dUViYktFbkdOeDRycXZINWxrSGRoVGFr?=
 =?utf-8?B?M0lWd25YRTZoR2ZyNFpDOTBUdkZkYkJWWWVyVlpJdkh0NWtqQ2RRbFdtV0JI?=
 =?utf-8?B?ZHEvSmhsY2FMeGxaeENUMXIzT2hDZVllZ0tnUVZka2pldjJmcGNhMStSalc3?=
 =?utf-8?B?ZHhGWHI2SFB6QVkwL0YwbmlSbm5zZFllMGh3WnNicnFSRDhWWUpSeTVjcnMv?=
 =?utf-8?B?TUY2cEUrM3QzbUYzK0J3Mk9Nc2dUT0ZHbHBlR3FmbWpwQTdCVmFYRGR4d0py?=
 =?utf-8?B?NmVzTjlxcVV1M3FieU1XWHI0dEhKdnZKL043Sk9KbjVxaVlDRGJPU2FTbDlk?=
 =?utf-8?B?OWE1TDJPM3JhVXVpNjVvK0hvRFBmYk83bm9iNE4vNzJOSnJDeURnTVpCZHlK?=
 =?utf-8?B?azlyMGtSYjNYMUpCQXMyTE94OG4vSlBVZS92bldNbjEyZ1pFSVh6RWRsdDBI?=
 =?utf-8?B?czBnbEE1dkhtNUI5WXdBcFlZQWs2bzlXUWtSa1dNaWFqSXpwaG0veWltSkw2?=
 =?utf-8?B?RGpPMGFXSGh2eEpVaU0yZ1B6KzQ0R1lzSEQ1by9ZWDVNUlpLV0dFUnlpb0Fh?=
 =?utf-8?B?NVV3NTFicGxjVzJkbGVCL0xDU1o4OU9rTzBoWHMxTFVjMUFscmVLWTRzRXJX?=
 =?utf-8?B?M0FJRUY5RFZiaE1mWFh5N1ZxNnBHV0FMSEdyb2ZnN0ROZFJkOHM4RTFseXVM?=
 =?utf-8?B?Z2xvT29Ya1psdGZNR0R0elQ1QjNaelV1S2tDQmptcmxiQmJsVFZDS2ZvcWpo?=
 =?utf-8?B?WWNNeTZZRDA3QmpZc2gyYXF0dk5IQkp6U2Y3dVJXWGdMeVhaVTUwaGh6bWdP?=
 =?utf-8?B?YVRsajJYR1NEcVI4QW93cVgyMnhZVVhNc0lmVzZ4dXBFSHgra2NBMDJuM3Ny?=
 =?utf-8?B?dURCVlV6QzZaSkxMT2VHUzEyOU9Uc1VNOWkybThrZXo5ODJNRXV6OUJTeWo0?=
 =?utf-8?B?SDZUclFaU05YdURsSExCczhpaGN3ZjRyRGdsaEdUOEVQRllFQmRSdjdpQlRq?=
 =?utf-8?B?WGM4VVBpWWdGN1ZWN0UvSWxTcjBMK0g5YzJxaG1DQURMOGc4c204RnZrcys0?=
 =?utf-8?B?YVk1K3F4Z2xqSHkxVVpONG1FZlY2d2ZPcDdQcE1iSU0vZXh1TkRxT0YxNTVj?=
 =?utf-8?B?cmJNUXBMdUVWN0wwVnU5NjQzS3NSRTIyWU9uS3dzYkV5d2hvdlNKUGdkdkY3?=
 =?utf-8?B?dnNBSHJYcGNTc2tSVFp1cm4vdmEvbWNNOFYzTWJYbCs2OVBVRHYyVnBsa1I2?=
 =?utf-8?B?eHo2b05sTEI4TTdLUHdCcExwaVpEc04vbVdUdk82SmYvZnE4eEhEbEMrODEw?=
 =?utf-8?B?NDJkcjdyTWFmWE1PT1krR3cwSGh4K2JPWVpNbHN4N04wSG1QQUZ0MUxNdytJ?=
 =?utf-8?B?NEk5K3FUc3oraDFMVFNRT0ttZFRySzZCS0xyN0x4NGIrMnpZWlBDV3RMMXR6?=
 =?utf-8?B?bGlkc0VXT01zM0x4dDRVTk0rcU1PcEl6clhiZ3Nod3dEUmFWU1FTZzVRL0NH?=
 =?utf-8?B?b013SlZ3S2x6cFF5SEV4T05vcW16cjd4eVArVXVIMytpTTVoY2NHZGI2T3ZK?=
 =?utf-8?B?a25WblBSNmR3NnowSHBkbmV1MTBqTHZYb0c4R1RzUzlNc09RYzQ3VmFUOUFv?=
 =?utf-8?B?S3JISXNYNmxPbE1ydjlrSHNNTE1MY0xTWWZ2VDFoeDRzbWhuSzZLcVJzQkp5?=
 =?utf-8?Q?vvCbaPMxN5BazsvRRn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a5948-efd5-445a-c3a5-08de85192c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 18:07:09.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsJTtXxaIE9XJaPFbcKp7mIAU76JH5UwkVt4/YsBCumX51zVakZMSbj4wkNqsZZ1LqNrjIpAB3evYdqJ5Roy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjYgMDM6NTQNCj4gVG86IE1h
bmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBBbmlrZXQgQWdhc2hlIDxhbmlrZXRhQG52
aWRpYS5jb20+Ow0KPiBBbmtpdCBBZ3Jhd2FsIDxhbmtpdGFAbnZpZGlhLmNvbT47IEFsZXggV2ls
bGlhbXNvbg0KPiA8YWx3aWxsaWFtc29uQG52aWRpYS5jb20+OyBWaWtyYW0gU2V0aGkgPHZzZXRo
aUBudmlkaWEuY29tPjsgSmFzb24NCj4gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE1hdHQg
T2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4gVGhvZGkgPHNrb2xv
dGh1bXRob0BudmlkaWEuY29tPjsgYWxlamFuZHJvLmx1Y2Vyby1wYWxhdUBhbWQuY29tOw0KPiBk
YXZlQHN0Z29sYWJzLm5ldDsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiBhbGlzb24u
c2Nob2ZpZWxkQGludGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlA
aW50ZWwuY29tOw0KPiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGpnZ0B6aWVwZS5jYTsgWWlz
aGFpIEhhZGFzIDx5aXNoYWloQG52aWRpYS5jb20+Ow0KPiBrZXZpbi50aWFuQGludGVsLmNvbQ0K
PiBDYzogTmVvIEppYSA8Y2ppYUBudmlkaWEuY29tPjsgVGFydW4gR3VwdGEgKFNXLUdQVSkgPHRh
cmd1cHRhQG52aWRpYS5jb20+Ow0KPiBaaGkgV2FuZyA8emhpd0BudmlkaWEuY29tPjsgS3Jpc2hu
YWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBrdm1Admdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMjAvMjBdIHNlbGZ0ZXN0cy92ZmlvOiBGaXggVkxBIGluaXRp
YWxpc2F0aW9uIGluDQo+IHZmaW9fcGNpX2lycV9zZXQoKQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAz
LzExLzI2IDE6MzQgUE0sIG1ob25hcEBudmlkaWEuY29tIHdyb3RlOg0KPiA+IEZyb206IE1hbmlz
aCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+DQo+ID4NCj4gPiBDIGRvZXMgbm90IHBlcm1pdCBp
bml0aWFsaXNlciBleHByZXNzaW9ucyBvbiB2YXJpYWJsZS1sZW5ndGggYXJyYXlzLg0KPiA+IHZm
aW9fcGNpX2lycV9zZXQoKSBkZWNsYXJlZA0KPiA+DQo+ID4gdTggYnVmW3NpemVvZihzdHJ1Y3Qg
dmZpb19pcnFfc2V0KSArIHNpemVvZihpbnQpICogY291bnRdID0ge307DQo+ID4NCj4gPiB3aGVy
ZSBjb3VudCBpcyBhIGZ1bmN0aW9uIHBhcmFtZXRlciwgbWFraW5nIGJ1ZiBhIFZMQS4gIEdDQyBy
ZWplY3RzDQo+ID4gdGhpcyB3aXRoICJ2YXJpYWJsZS1zaXplZCBvYmplY3QgbWF5IG5vdCBiZSBp
bml0aWFsaXplZCIuDQo+ID4NCj4gPiBSZXBsYWNlIHRoZSBpbml0aWFsaXNlciB3aXRoIGFuIGV4
cGxpY2l0IG1lbXNldCgpIGltbWVkaWF0ZWx5IGFmdGVyDQo+ID4gdGhlIGRlY2xhcmF0aW9uLg0K
PiA+DQo+ID4gRml4ZXM6IDE5ZmFmNmZkOTY5YzIgKCJ2ZmlvOiBzZWxmdGVzdHM6IEFkZCBhIGhl
bHBlciBsaWJyYXJ5IGZvciBWRklPDQo+ID4gc2VsZnRlc3RzIikNCj4gDQo+IFNob3VsZCB0aGlz
IGZpeCBiZSBzcGxpdCBvdXQgZnJvbSB0aGUgc2VyaWVzIGFuZCBzZW50IGFoZWFkPyBEb2VzIG5v
dCBzZWVtDQo+IHRvIGJlIHRpZWQgdG8gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24uDQoNClll
cywgc2VudCB0aGlzIGZvciByZXZpZXcgdG8gRGF2aWQgTWF0bGFjayBhbmQgbGludXgta3NlbGZ0
ZXN0DQoNCj4gDQo+IERKDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBIb25hcCA8bWhv
bmFwQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Zm
aW8vbGliL3ZmaW9fcGNpX2RldmljZS5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy92ZmlvL2xpYi92ZmlvX3BjaV9kZXZpY2UuYw0KPiA+IGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdmZpby9saWIvdmZpb19wY2lfZGV2aWNlLmMNCj4gPiBpbmRl
eCBmYWM0YzBlY2FkZWYuLjMyNThlODE0ZjQ1MCAxMDA2NDQNCj4gPiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy92ZmlvL2xpYi92ZmlvX3BjaV9kZXZpY2UuYw0KPiA+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3ZmaW8vbGliL3ZmaW9fcGNpX2RldmljZS5jDQo+ID4gQEAgLTI2
LDggKzI2LDEwIEBADQo+ID4gIHN0YXRpYyB2b2lkIHZmaW9fcGNpX2lycV9zZXQoc3RydWN0IHZm
aW9fcGNpX2RldmljZSAqZGV2aWNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUz
MiBpbmRleCwgdTMyIHZlY3RvciwgdTMyIGNvdW50LCBpbnQgKmZkcykNCj4gPiB7DQo+ID4gLSAg
ICAgdTggYnVmW3NpemVvZihzdHJ1Y3QgdmZpb19pcnFfc2V0KSArIHNpemVvZihpbnQpICogY291
bnRdID0ge307DQo+ID4gKyAgICAgdTggYnVmW3NpemVvZihzdHJ1Y3QgdmZpb19pcnFfc2V0KSAr
IHNpemVvZihpbnQpICogY291bnRdOw0KPiA+ICAgICAgIHN0cnVjdCB2ZmlvX2lycV9zZXQgKmly
cSA9ICh2b2lkICopJmJ1ZjsNCj4gPiArDQo+ID4gKyAgICAgbWVtc2V0KGJ1ZiwgMCwgc2l6ZW9m
KGJ1ZikpOw0KPiA+ICAgICAgIGludCAqaXJxX2ZkcyA9ICh2b2lkICopJmlycS0+ZGF0YTsNCj4g
Pg0KPiA+ICAgICAgIGlycS0+YXJnc3ogPSBzaXplb2YoYnVmKTsNCg0K
