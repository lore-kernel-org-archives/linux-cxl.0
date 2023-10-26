Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2E1BDC7
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDeZKy+H"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161310A
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698340990; x=1729876990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FSf+i7ZeR/S6Bh3buvR0OzVtk/4WpJOZr/0sMLzjAwo=;
  b=IDeZKy+Hv5SSBl7BY3y4zR4oSO0XsyV3N6h/o//t5VDXGZZMCYpobCP6
   DhyLsi5DG9z0DvZo2IlaswYnIjC5NfrqUhNSyvtZ7hRHDgdTJgNHiHi+l
   jcPlcFA0voHUHWV4kCTTIY7VXX0ijhOOsyA4UdiwvnddOHuop9ZxE49FB
   ZZsEi1XW3QTBSkmuqMKKS/in9XHG894UrZj2GG3Fsm4nOQs8V1MZyx0PP
   r6HhQ5fWsj6lAgmzSJ8ZVwTlK/7ZlQ1RLYXg8DlHnHxSPYVzHwpUDfQ8v
   vsVDGlsGDm182DzvcxqOx5LB+GDJMfI62CKil3FOJkekTvfLJDmAxYjgT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="366954241"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="366954241"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="735792246"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="735792246"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 10:23:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:23:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 10:23:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 10:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyLvVCA/wFiKQL0ogb9QyLyPups84K17Mhz+kJxdlCq3hf5qItdf7Jw95aQBq6RnIf3jYiYatY1e5FeK6JXeQsnZEL4+RZ5QH77zHZ113GJBIkYTRKoVgx2kudv4v6/BFlvOeP3uSYPQvOPc/KABdjQX2rgX6tekwMHpPfDYPpYG/A6rqOJNrp6WaV6PE30RplSTxhdvFzDsRrS0fgWDSx5TJCxB7lNEtoUTx2EPY9CcpwEOUOl5ZfJJ7bLVxSKRgpPCdszImMIediNO4koG8qpjUIvdWcn1ncovRfYocUUEjvICnOTfuNjYc2v4Ti/0OYWeCmlfxx+Q61qlPFoB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLHl7K9UiQtrCX2Ge7opbjgH0dTHcUfOTt3PjtU0jPc=;
 b=gltfoIUFs7x2jFMuomsYzLJYs3VQBzhf1vlXjXfm8lRvQ2yqECTOSFWvh1edgyxc4rQlJS1Q9h4mrkZ9v6jssUJsJGwME1DgW3gHuureFhz7O7wp59HMiWWyTW4ZSvny8VXNubLnE5QzOsWjoB6Gsn/Bq46NUYFE00JcE+w9agRqMMe5zFISgNcwZDQ6ViSyG6Fdctfv8bVyR5SjOEmeDXR1SLhlD5PI1pius23wmSUY8roAmAafV9Qm+JyrF87/o3ngJlJ30LWWh4TlMgyBaPUt+jG0qm5W/3fTcOXFSsUjT5YRiT2H/Gq8+SXAfnwLIX1zHwgpAGllU3sVXqWJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:23:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 17:23:07 +0000
Date: Thu, 26 Oct 2023 10:23:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH] tools/testing/cxl: slow down the mock firmware transfer
Message-ID: <653aa0785f533_244c8f29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231026-vv-fw_upd_test_fix-v1-1-a6345df5550b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026-vv-fw_upd_test_fix-v1-1-a6345df5550b@intel.com>
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 25486537-6f74-424a-3b2c-08dbd64837e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faejVZiiTNrc6/YgoIVnhNDzswRQLR6h8YBuo55SZqmcNAgWlPcHCLpL2ASw+T4Vc90mUeUa3HMzH3dU7sUdBAasCvZkOun3DcbyQc/BLPIYBGjAM7RrsP00cJ2iue9NOmdnIYiEyVbjCdvrpwET0t2xlqVFJRYy09NZ8UsZ3+Y8Cc/Bj+F4wFPyazGbCruUe0fey9SAkgPhcV4yFoK2dSdVHh5L4s6pMIGR4nt88BF8FVEBZ/fgOcZdNGJRlGzesWWG1diR7s2aYOfo9/HIjSpJIV30Myez7JG0d2sEr4/56+6Rq539tWKvOUycAkxBindbO8fMoCNJIyW6AB+l+CB33mh/VfT6IsFnBtStfEdvz4k2Sv/ddkx6oaW/hsqSeerR/8MCfbbck+0JGM7AjA0utaF2j7eS51D5hqe4ytaDNkH0xkjOg//CtIbI/DRKLSEzf8okOTXZ+EgtG+w6CWDykytJvGMCeZVoOb4bGq46XkjWmyz06EhiOwDn0TPnPWAGmOK7d9aFsdevgBhEZAv0HNBtpLU4OLtrXZKeVoOw14Tssq39IwK+pp/P0vWH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(26005)(9686003)(6512007)(38100700002)(86362001)(82960400001)(6486002)(4744005)(83380400001)(107886003)(478600001)(6506007)(6666004)(54906003)(8676002)(8936002)(4326008)(316002)(66476007)(41300700001)(5660300002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MJF+DZy+k+4H5WgssJS+A0lktFh9FlvHwDed/qucj8plGi50AitaxiWdMY7?=
 =?us-ascii?Q?1ueNXMfvyYcEjDqSvdGO3MCYfgt3UEBI6iQYhG7aQ3TJ2+u+vxY+cIp8JZP6?=
 =?us-ascii?Q?pCeeuXKK5jcDUoXukImMRZ5gIcVtRWCexn/mEjghkSz0/k9GOBWHssxQj4Vw?=
 =?us-ascii?Q?KoOdp2a3hAeNaTzTv4+RcazrvcyOa77eywvO6DJpSv/w2NXzO9cdzga3DKKl?=
 =?us-ascii?Q?ZFohhEIG/RaO8Z9vKtC6Mz++WSfYlaXw1XQz8DSIdv5/txgWTe0tpIZST1Gi?=
 =?us-ascii?Q?b8WrFt+WWXugQmx8LPff/NkVo78jnN52qnHyJ7t6Le1Pki7aMzu/mfoMfyvi?=
 =?us-ascii?Q?4HftgspifpNT9usvx1uB6AwiU/1vqwE7397HsZb5GRI07lwboYoYT2eRsvbp?=
 =?us-ascii?Q?zb8gvNEw++IWhPNEI/wRpXNz7Jn+A9gLmJsVHKfOOwk8euMfOaauSnFMT7kP?=
 =?us-ascii?Q?1+spLpymeElczppFUPPI+wo4FvLV8T1byhQxxl7PhEJ9QDpvFsM88CFHEUXo?=
 =?us-ascii?Q?Web86OggpYNudEmnKFkX2KWT+LFEd+MH1OfmjBLwVMLr9FdjUvK1rD8aPwnS?=
 =?us-ascii?Q?qkaXb7TTdV7o7SlAVyzR2vlE4OrOdqVdYwYt9oVV02ZBPohTRCotkPW8vO/X?=
 =?us-ascii?Q?+tZ9DrVaAZnI9If743rh6pE1TGSd4LBlfPhOYuB5WZI0VM3bY3CGNc0TXRlR?=
 =?us-ascii?Q?fxPNFm4mwYp2F60jaXkFt1QzGQQvHCi63XUXrYowycczC4SAgglmKu0eTHCU?=
 =?us-ascii?Q?dnvmAVyYqe/dd451tdl4ITe6+dJpvBjaVFHJBUi5wxFZ7jPMDioA2d5mLB/O?=
 =?us-ascii?Q?I/04JcVZ8XPB00avIJINna4i2RJyGQDtSB6kQf25bEZKGeWeeQeECVpbEe2R?=
 =?us-ascii?Q?gSjjiDmC19w3cQg9UgdBjryOQAybsdTBU0KTkoAd51wAXkV7Zk3EZduMDdFf?=
 =?us-ascii?Q?ykwBRgze//12CpVyS5EC0ExjmqSRzVdYgGZmy5/SJ+mqmfSyFPSfMOMWyXC1?=
 =?us-ascii?Q?SEO2z/SW+4FjHe3ywCcfL3stca23UGcVy46dLRkKSF/ZX+lPwW25eCKMClU6?=
 =?us-ascii?Q?YbI9euWQKMNKmrBvU2H23SV26eSFgVGgINZDMCd0SMbFNxp17hQLno1x2pcH?=
 =?us-ascii?Q?TdfUSApUMEsW1FHy2H4fAeoI+fb+cONKCW37VFTSk8mCIaEdJe7lf9gqp5TB?=
 =?us-ascii?Q?cR3smGXShGtA26tgsiZD8HaF07O8blOUQA5an4+PaxEDPvHd1TqYqKW/L3lV?=
 =?us-ascii?Q?9N8OgQeeHvX1KE2UuevjWTqIHxc9Q+ywp3HH7zKhgd67gmrjRkTP6+vXQarM?=
 =?us-ascii?Q?vqby+XKfDVj9dyd5wz6XzMpVlRijdCfLtT18z1ANBwr9d+GXnLuUxVuIv/UP?=
 =?us-ascii?Q?VMojaF6Fkoil3evul60P4Zd/L6JJCqGRuMUGm5Ltb/hzOjgTR/jmIjui0+Ql?=
 =?us-ascii?Q?LAJZSxI97tUcqaCac0dhjKAqftccChCmdv9yAgvtGZH7UcoBvV559H/OFbkR?=
 =?us-ascii?Q?CXexwgoMMYs/L4f5NpTm/esuLtMJwkx7ecnQom+Po1WD518m56URmiytC1yV?=
 =?us-ascii?Q?SngdRm1U4wiLRt2Ob0lP9ke0C5+vaTjV59idfDtE1S+ZfAJNdwBx1WeTLPh0?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25486537-6f74-424a-3b2c-08dbd64837e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:23:06.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTAOP5jQ6kHqoc4IKNtkWUl93UgZyDEasZVc1cAhWxHsWrLojNJmjQUD0sEfGHtsiZ/gQqIiY+bPiHTdXxXuiedK4BsExDrMfRVKOOfl5T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

Vishal Verma wrote:
> The cxl-cli unit test for firmware update does operations like starting
> an asynchronous firmware update, making sure it is in progress, and
> attempting to cancel it. In some cases, such as with no or minimal
> dynamic debugging turned on, the firmware update completes too quickly,
> not allowing the test to have a chance to verify it was in progress.
> This caused a failure of the signature:
> 
>   expected fw_update_in_progress:true
>   test/cxl-update-firmware.sh: failed at line 88
> 
> Fix this by adding a fixed delay (2ms) to each firmware transfer
> request handled by the mocked interface.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks, Vishal!
