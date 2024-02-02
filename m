Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AF80626
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899577; cv=fail; b=bsKNV0cK442SNmDyW77lQIkaghX+49BIPR0Sfd4kCni7ktZrC6W66AQN33EHmwOGPbnCChoJykL6ErP3xSUOkbvzFHYvDGt6OUBGxA2S74xj2KGxu86ymgJDeL81acOjoIa2VUDkuYBgnxPzTm0BiKX/34j+6eTuC5MSMsy8dlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899577; c=relaxed/simple;
	bh=Lu2GMptXBzh8YCueRAOktgrle22pqAB0vfOv5ctGQ2Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ogNHvZIOX3h8Jx+tOKMBN+xdHBn+KcpETchJrJ4XRwD593DvzlfsNpAPDljabI0N9FCLbsfz5rhrIVO7YeswCHMeaUmMQ1AfnzkPPOqK754UZDlWZlkWHSpWVdZ9hqd1JdQU3SSPUy4BlKmAHO2sfxnSXBMmfKAfyHnOywlyR/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.onmicrosoft.com header.i=@asteralabs.onmicrosoft.com header.b=Ou0EKZSD; arc=fail smtp.client-ip=40.107.92.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.onmicrosoft.com header.i=@asteralabs.onmicrosoft.com header.b="Ou0EKZSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msgjqNL+PzbcAwGZVQ3aRVTZ2cism9f01Iy6pyTsy23aSHHm5khVOIXgrXEtX4f7zrNbWn9O781JuRZVluw+CufFf5np5rVL4pcZUZGFf+DF4GBupBU7luN2RiPIZ50ES5AEpvx8TCz+JidLos9804vIwE8l0R1KoC6gpWvkegDKcOYJ0zUG9iMUeXyeZCO62ne9E0RVKZsyQ9VvM++G0xRVaBlRjpsawS1HWkpCDBQELDqlRWr/WViBDfXkF/NzMpzDR4kh4yfVWa5K2kcnMf1k3Yh+uSkdouldJSZbPXZNxMc7k6PCv8RM+s67mo2gtD8YBPHSTqDKuCDQg09LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu2GMptXBzh8YCueRAOktgrle22pqAB0vfOv5ctGQ2Q=;
 b=goE0rgWhGPFbm1SrNQlllhXyD0f7EP99RAuKq5/wm0rC6uZBxtUZlRv74nRLCpDs0Zo+lPXpbnG3X4YsJDmD3RxOOftpJM4pXxzAR4ytdZ3wKVrty5zQTkeLFZ55slhVxQFY5L227OJtZRsDlyocv+vVPQJ5PpASRSDQGq5XFDLKRJ7XPB3YPqv3t7hSM/e5LZlNTE7/cHxTAVZT1CLRaeNRT2B5ilWSTwQALa45UjpDGMOSIM1i4KHzI1dMBUkg9W0kmwgoPZTGOJkw6ujMCggPubNygZW0D2Tz9q9YlHpzymseUw4nsGjDkW7ZJu804EGXHLxMW9mWsY4SpxLTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asteralabs.onmicrosoft.com; s=selector2-asteralabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu2GMptXBzh8YCueRAOktgrle22pqAB0vfOv5ctGQ2Q=;
 b=Ou0EKZSDThGqlEMswfgfYQoOxrxolPgkTJgnmR5Hgte8AtRg0LWD29eSrl8EHw4PVQMAchcMQBaSONJGDq5Blu5YdzKukpmLd7qx6lP9XZgWuHkJS8mDmxl/Ti03iEksxSKGD6rfLuIqmJvrQeHL4TUbPVeGfJADU2f7Y2xsFiM=
Received: from DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:a9::5) by
 CYYP221MB1093.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:c5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.31; Fri, 2 Feb 2024 18:46:12 +0000
Received: from DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5406:ff4:6225:fa26]) by DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5406:ff4:6225:fa26%7]) with mapi id 15.20.7249.017; Fri, 2 Feb 2024
 18:46:12 +0000
From: Jonathan Zhang <jonathan.zhang@asteralabs.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.williams@intel.com" <dan.williams@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>
Subject: how to associate cxl_pci device with cxl_mem device
Thread-Topic: how to associate cxl_pci device with cxl_mem device
Thread-Index: AQHaVge6sRN1v0wJkUG3rOcprzl+vw==
Date: Fri, 2 Feb 2024 18:46:12 +0000
Message-ID:
 <DM4P221MB0932B81DCE6B03503E2927D8F4422@DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P221MB0932:EE_|CYYP221MB1093:EE_
x-ms-office365-filtering-correlation-id: 2b30e94b-1f54-4bd1-efb7-08dc241f3a95
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b8HQk5fo5AlmRUTqg2zxc5Jw71riVHM7Iqj5cJL03LKVU9lpaOg+d3fF1amFayzQj45NLW/hzy571sj8mToR/L/TjyoOQbysdgA6syo432ccLSIWcOfVoVtF3wo3Jz98jU6sBUIW9uke+VLL/xkII3Bo3EuqBPURnV13TI+uSP5xFSQfafUc1zx6VHD8+FYVnjC5y8EVmolqfxy7MW+omPVfVCWO/eWacaTCyq+wVnPPFqrYiVYytgLwdsiXmqUxDuGL1h3+lHhKous5291VsqgDW1BnacfbFZZTZmoBZlouVqs2FZ7OszOW4XnENhHRgRU3huIwAL1v/x/9REW3DvnUSkdX1hS1+HH1QE2gSvO+vkJfm4rgMG1i1vLDW4iH99CmYcPt7hCxGfoa0krmFTEoIqcLJqyrI+to7SN/+rZ8sziHdsaGHJeS2/39XH+6bngEkTANU1Yj7jNDSAEjg/Ar01ugjYN+TOlhX8J/6t/Xt+/4a98t2OS0HQxnN3D1e4RXaIhagCGvzP+C4OL9f9G2F2f2IYWyatrI8oNPRnMgd8LgTWHS1EFIx8OqyH0sJAYYq8UmklD1suN06cOU2cHUBH2pM1Eg2PuZEVcpSDplWz9aZdjdWU6j86Wr9RJo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39850400004)(396003)(346002)(1800799012)(64100799003)(186009)(451199024)(55016003)(8936002)(4326008)(8676002)(5660300002)(2906002)(52536014)(478600001)(9686003)(44832011)(86362001)(66946007)(6916009)(91956017)(316002)(66476007)(66556008)(66446008)(54906003)(76116006)(64756008)(122000001)(4744005)(33656002)(38100700002)(38070700009)(26005)(71200400001)(41300700001)(55236004)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cJnB2FdKEDduiwr8xwgOrWmTDDiN2XIfCuMnopz4vHHmPBLeDHeMQT6SG/?=
 =?iso-8859-1?Q?r/n/LpPz0di2AbDliP9U4FNmX3z7yun6Uk8tlq53z9iOMm1wPV57Kj2BWx?=
 =?iso-8859-1?Q?KQnLumVIy8yDr78eIb+XgeyUsOJmYoMxkpPhnnrdtBAzB0nYg+WBJc9iSp?=
 =?iso-8859-1?Q?GZzC9sl+tEkfzg2T3+voBuGI1/p8jSUSm/OJKIErz6Vcq+Gfih/pAZ9fy7?=
 =?iso-8859-1?Q?5enQKSOCQFknM7BOYEh6EZnQ3wkqAsXZ6fX/sdI2Ll9fsyAVuQ6QPyC9so?=
 =?iso-8859-1?Q?fvTq+dkS9BpD7U2HxGjQc4e9aJ7GS0ticxg838NR/F9yOjY0E30BeYHtXR?=
 =?iso-8859-1?Q?R1IVv2Cjs55/J2yapoM5YpeRAqbi4ZORjOWdwq6C3Bk8luhnAkFvGwHixy?=
 =?iso-8859-1?Q?qNqNhHwfjd1hIxlaQI7SYaANWXeEZz6auOL330X+qYsHDqJEsxx0YPmSlo?=
 =?iso-8859-1?Q?dwOCB8Jr73US5ZkEpdEicghuDarDaK53mPQA/zm5pqxozYM1CxAzVBEMv0?=
 =?iso-8859-1?Q?Ca2/DmdCa/QijJE6D2BAktl/Ob2fCq8mjfRWWDY3WpqA3jnU/Xe9LJxUZA?=
 =?iso-8859-1?Q?zIFHlKESlTbvtFvbG/Lp501Wi1zP6I7VUG/9Dd4DRV3Aq1ZcBZe883syvf?=
 =?iso-8859-1?Q?4N0Ned2uZCXSJbkIigZaVIJSU7kz/iX3+xbnM0UdNTlKkAMS6g4qnu189E?=
 =?iso-8859-1?Q?psQuObgiCY6LMtFTTm80C3E3oq5Vlh6NzQUgyYpuk6y9PZYnsRIE8tmTyV?=
 =?iso-8859-1?Q?74CyTftegfTQVD/uf2ImkyqDd2bjL1Oao++3RYrdDEVBj+O0d+C4D7PhDR?=
 =?iso-8859-1?Q?hWTJUh7JTDDALUo36pVn3a3n9idmUTtkuhUS2Mz+mjcfG9TDaJfKpgbGK8?=
 =?iso-8859-1?Q?MwAActRgmWAymF/iAyN6CTKr/IM8B8IUzM72WgIR/sM0QVGvRA7KyVgnOY?=
 =?iso-8859-1?Q?oCfoIWaa40bRGI7UTxXcy6R0vBRhFNmHSxm/Xv6/6MjDIeuoWbWXjL+hbE?=
 =?iso-8859-1?Q?n496+4WmbYaZsVeS9LZahn7yq5mftKsT56ac+5z0Ha3t3IJhkrpGSvdjSW?=
 =?iso-8859-1?Q?EwX/VVm7BUIUleWsnJuMMuR6b/i97gAQOuCJMPGl17/yUhe/Nrafaab2Ux?=
 =?iso-8859-1?Q?fspd+uLUBiP1PI7IlruwdcvUyEGc0nO99FrNPpewXYa7zmh5pDwXeL2HsM?=
 =?iso-8859-1?Q?xXokcUBrKffc80ys/7De1XtKkVH5Z1dqUdpzSQ+CueOCV0e+JxsxxB/il3?=
 =?iso-8859-1?Q?ipT9OyQPuUSoTTiDxToz/Ky9PnmwVXs2vWMh5tviS+p9pPqd0t617YSOXc?=
 =?iso-8859-1?Q?P/dOF8Su1NtYeXz1MAzn2QWkzKeMKEhQUGTF7ehHE8Hth82iXaeQ56U9iW?=
 =?iso-8859-1?Q?fM/V4gukd0nhpsQBIYDYQYkygtVXiu1mBOhVOd7RUIyNNM9xSjMGcV/zqa?=
 =?iso-8859-1?Q?GyAcOiX1B/MBN9wbmiDL5CX68BP/9wZ6MfYYVquEa7pVUC4kBEhMZBbQzY?=
 =?iso-8859-1?Q?yrAQfjMdRledF2lU0YKJDJC7kt/4E8yns3cjirDzn6+ghhXhwb54oDeElE?=
 =?iso-8859-1?Q?9ldMGZsiS7CpQk27Vf5zHcIMEap9k4s5IOMLtEYQKi7aTM9rbTzBbAj4IV?=
 =?iso-8859-1?Q?Q9Uv3xMQYjRTB2/kF12jbnsIikzZBUc99ozFznD1dXYCtojdFRb8XdJQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asteralabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b30e94b-1f54-4bd1-efb7-08dc241f3a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 18:46:12.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDCSVpG4o8dD1t2AfFgfl2wFUmerRkTQHlFI6SHOT826kMC1PBSmkUntRZgz6Q+Ru27R1eTAgFLLfF62x07eMR+5XQxckZsWYb0JBcXuyL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYP221MB1093

Hi, I am trying to find out how to associate a BDF (cxl_pci device) to CXL =
memory device file. =0A=
Suppose user says I want to operate on the (CXL memory) device of a certain=
 BDF, how does =0A=
user space find out the corresponding /dev/cxl/mem* file? Also between the =
cxl_pci device and =0A=
CXL memory device file, is it always 1:1 relationship, regardless of device=
 configurations and=0A=
interleave configurations?=0A=
=0A=
Thanks,=0A=
Jonathan=
