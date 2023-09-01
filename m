Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E75FCA0FE1
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 14:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjIAOST (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjIAOST (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Sep 2023 10:18:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD810EC
        for <linux-cxl@vger.kernel.org>; Fri,  1 Sep 2023 07:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnnvbudNEI79Hz4VTo8I4OQu66h13ztkujZAmDXxAHDxCnmcHHRbls9DyNDCFmRM1oKbR3dwEH1Aja6lpf9q/R4wLssK1nDGypyeUuAFNPxk2J4b0/CRpvPtgQQOMb1uVr/sip00ZDuvZ3HsI8Vig9Y2k+XEZuQWX2xHLIwR1yo78YGNg/dZwf6o3B70sqE9TYCRQp7fw7vkFCL2PnBIDZuNrDYVQvis8znvUtLLaVhUtfJ2ilTSIJjC9m97gkPJ3hackvoPcjmCe+ifomP4ve+ac0DPGswu8DzP/v/LuwtE7dOhV+rMNwI5OfsafdrIJ8ezW9tm7M7joFSa1nnIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ5Q8NzdP3LQR8AOfpSi73HFrBd7S9Io5ClP7AlNAUQ=;
 b=PQWA6VNGvDZgbxaJ6avy7kRZvrMcVyqo9vlct7aZcTTfHPMYseqtiWGfTopOAh56SqG4nqO+Gws9mCQ8VpIxMaBkGhuYf+cxcAELxd9OFywXdIXh1C6PqjrGubVrBVMbU7okD3CxX5lU7M5Nia8Bb1cH4E9+14SnkEzqSZQ11MyGs59eQkaTPeux9y8uPVCNyFwEegDxOZ/htzS+/AiAuZMxLU5iqE9mGS7+4TxZuxbDYyXqtRxlRBWJzqxiqf5T1H4YD7LJEUGwPvyrbM8yiBSRaMC9lQU8cJDevp9VA34ZC+EYxGUYF0HMswqFiXSapkwZkthk5lVwXfisE+xsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ5Q8NzdP3LQR8AOfpSi73HFrBd7S9Io5ClP7AlNAUQ=;
 b=b9jFAi16LS6wFYCZuV+BZH1BcXGm/w2Y0CCrb4DI/BQz5CpJO+1E7bVvjUqlu2lRVG50C1jDQgp0cS6NpTqkyCLrlraaWuFnRgMW7YvVCtdOhtx1Rm+AUAhyplPntJpsM0OL2sCm9duMPSyI45xPjKKpHdnFMU2pzLWOUIlaJTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6041.namprd17.prod.outlook.com (2603:10b6:208:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 14:18:12 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::cca1:194a:9b9b:2833]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::cca1:194a:9b9b:2833%2]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 14:18:12 +0000
Date:   Fri, 1 Sep 2023 10:18:08 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Ravi Kanth <mvrravikanth@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
Message-ID: <ZPHyoJsZDnzpU7C4@memverge.com>
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com>
 <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com>
 <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com>
 <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e32695f-bc3d-4027-ae77-08dbaaf6464c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpea2vQkM7USerdUyGMQVcJV08gXV34cuy4gpKcGdmjNaFOpYHGFT2oWr9Nu9HY6uGy7Ked2ScXD2RK/sRGARPCfUk6iwHLBlSJup7jnTuDo8spjQMrmiHuFPYf4dAzKP7aOtg2sS3VVzZzpkDgOJYSp2P+8ZL3lmevMEAxowN1bXh5E9ZNXUCYIi9AtPwicx/IFQaocXeYouvv1d12QiF2JaoPZEV0/Vk8V2tQyg/NVTT3LcD/dMfej2dB2xBrT++xrhmo7T9A+GTeqWoERo/YNabV3b/TvmnnvEQycMA9QbeD1ds/5RLPEE41jH5CYw0Kw8oCKbCAHUM9i26q5K5fU2Z25l70Qfplx987zNxD3SJZtC4Q330s/f0/9sW0AM+82wkvKA4bWQWXG/GisTGqmsbvXIlySYpzQhGqdXx/p8DkOzhHOxlGR8hlXezo2Eilyc4fTAel1S7iH2WT8g5kdx2yKtqddqhTF60O/QQtmP0/nsxvqACam1cuAfvG6tYZ1aApiCogzO9DnmT43vGRycFkAueblAhRPegR5toNSXPhig9ShEDo/ETv5F7z3LQNVtDkR870wclE2eKWMUrEbk0hvdp8Q4iNtDCCtZGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39840400004)(346002)(396003)(451199024)(1800799009)(186009)(41300700001)(8936002)(66556008)(8676002)(4326008)(66476007)(6666004)(478600001)(66946007)(6486002)(6916009)(316002)(2616005)(6512007)(6506007)(54906003)(26005)(2906002)(38100700002)(36756003)(5660300002)(86362001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3cgITy8vEZ/eXTzvvQbVjFkfcAKxWVk76xgpPzfWXj4ONqmKaNUrtkFrB0H?=
 =?us-ascii?Q?EcCPG8wbAVF9LbRqJKDZNqQiECur8hy8sW4PTQFa+h8py2mTidN6M0RoScdX?=
 =?us-ascii?Q?I0o+oOMDVSRTHsI7ACTzTLycvdDyjABoeU+Bq82l+bEMaPJbrEV2Uzlxq6DI?=
 =?us-ascii?Q?51eUYk2+Wy0y9k+XHbmd35oNTd7BXbFKMd6ylTvcn7eq9iN+L215LwucbdbD?=
 =?us-ascii?Q?Bg2FFxngCgoQljtYASGY2PNYxJXQ6eweuqEU1VNPa9PpbtJi6TI/1acnsZye?=
 =?us-ascii?Q?z+VETn5+VH6i34h96MFBa2JtYSp0zGQ+S0tFTPdMMNXT96JiiOBjOJ1lDzBf?=
 =?us-ascii?Q?Fcs+y52AotSFo9+KvO+KvOxkdUCJe1cOqhHMKI/5U7mHmqlqNJsDwShEcGez?=
 =?us-ascii?Q?qBVoQHRoy2Kmdb+UdmeF+urs953KqFa8a6yZ2+cbLkC0SAf4Ve5NawBkz8fa?=
 =?us-ascii?Q?UyCpGdF14d01y+pTP8T+AruIwsqGOGWqbY2V2wdTEQj9BF1CUNs3MkBCH71t?=
 =?us-ascii?Q?xa+XDp3qLm6jsY4C92rrhAwYzK967MgwV2KowRsGiIBFLds6ujEnzTFYqj/Z?=
 =?us-ascii?Q?kzUnGVlSw7E66HYiy2fZ9W/ppwHEklUe2o5Tgbj6CHx0JbxS0Os4B07F0ITZ?=
 =?us-ascii?Q?lkZXAUfBnCccG0iSXIMZxsxEc5XexN8TQ1xExaOsPI76XP4nPLLQDTUxr4rS?=
 =?us-ascii?Q?VvjdAYfbXQUTHCtFdCtFUqqWsoCPYm/OGrOdoVJX9LRlGGThaVjSnq2LqOCh?=
 =?us-ascii?Q?S1yII46TymxmhcfsRxcTQnjyjo1q/zx9Up3dC/dPlDLpmuvKTSD7Uco/kuJ3?=
 =?us-ascii?Q?bPFo8xbEScQrlZBvWlAB8kevhwqr8e7Crr916FGl/cfAK9McDP3tmLa+eph7?=
 =?us-ascii?Q?ifAqKG+g8hv8ibCVW/ImLOkScDxKpMQo7RrBKzt0gB7LYjgymCfb9H+vNGxv?=
 =?us-ascii?Q?wDiHYUzznLkg5ppI8XqPKO2yCIAeJOVfFu3XuGlOouN8bK6cLH+aGRG+KB1K?=
 =?us-ascii?Q?0pyBdINve7JzZ6/MRbxasNud76N1sgqRY5O5XuGQI22vIit5SHohYBBIjw+m?=
 =?us-ascii?Q?f2sSGbbUCjDpcSSRWEXoQ8Gw0FaCdYbzC0WUW9Q6uxkgjktIL0WjsCJOcs55?=
 =?us-ascii?Q?tp71x1oZDULL2aYrfyslm6tpB9GNpgQ+DovIHnX+qYEIM3JESQd7yWhys/lV?=
 =?us-ascii?Q?492IiF4j4gsXbKVzC9chu0t511fRl0c1VmVVixRGBGb+vLg5M6qEuFmJmdPb?=
 =?us-ascii?Q?JPmPh3T7eLeo6Z2P/3P/2ZNHvS8Cicr7gLh9AdeE4NRH1VfLDCLc2zAdDM5a?=
 =?us-ascii?Q?dio+zi6IlZ3G9gFdD62Q+L3EalJikVM05+u2g8/zVxXSublEQq+RTM2eSUeK?=
 =?us-ascii?Q?a5noFa+MgQN/DaITgvAcP/PNwYzMZQI9qlhs5yTMiDKapViEl+Ap3i7C2HHa?=
 =?us-ascii?Q?+ude2lwC8U3ORmrL2bdr349pPxttj++tFhYU5doMOFDBsJ6YE89zqvesADdE?=
 =?us-ascii?Q?yKlHfmAM9S/7fZerFtTl5BPVGs3pHsrPKx+k4if7MGvLf2ttzAdR8AcXR+mR?=
 =?us-ascii?Q?Y4A+qeupZOttfVW++TWdWwJZVRdQUmS+4cUdJCN//QbTe82rDCITem4eLI6D?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e32695f-bc3d-4027-ae77-08dbaaf6464c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 14:18:12.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPOp4B8W6XB/JXT1c9uxWtZC/9fwcFGtaKAfB7n7St8G2VhNL0M8oJOieF+5eDiPTjIv2xjHYGWz8FZ2xK9pTC0p4hDpcnUM980vgkdn9JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6041
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 01, 2023 at 07:33:57PM +0530, Ravi Kanth wrote:
> Thanks Jonathan. We built the custom kernel and were able to run the
> test tool successfully and get the data.
> 
> However when we modify the code to send raw commands, we are not able
> to send raw commands to the driver. We always see ENOPERM from the
> driver. Below is the code snippet. Should we enable some settings or
> from a code perspective should changes be made?
> 
> From CXL driver code perspective, we see that ENOPERM can only be
> returned by cxl_mem_raw_command_allowed(). Not really sure why the raw
> command is not able to go through but the MEM
> command(CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY) is able to run
> successfully.
> 
> Can you please help us here?
> 
> Code snippet:
>   cmd.id = CXL_MEM_COMMAND_ID_RAW;
>   cmd.raw.opcode= 0x0001; /*This is a Identify (Opcode 0001h) per CXL spec */
>   cmd.out.size = sizeof(is_identify);
>   cmd.out.payload = (__u64)&is_identify;
> 
>   printf("sending identify command...\n");
>   printf("cmd.id:%x cmd.raw.opcode:%x\n",cmd.id,cmd.raw.opcode);
>   printf("cmd.raw.rsvd:%d\n",cmd.raw.rsvd);
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
> 
> Appreciate your help all along.
> 
> Ravi
> 

raw commands are not allowed by default, you must turn on
CONFIG_CXL_MEM_RAW_COMMANDS in the kernel build config.

~Gregory
