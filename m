Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9901C64ED6
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 23:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWX2f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWX2e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 18:28:34 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B77417152
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 15:28:29 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230223232827usoutp01c77134607f7b2d2d81d276d258a6f0a1~Gl_Hq9BYB0093400934usoutp01L;
        Thu, 23 Feb 2023 23:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230223232827usoutp01c77134607f7b2d2d81d276d258a6f0a1~Gl_Hq9BYB0093400934usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677194907;
        bh=0V1yjcMPfJWW7Gw45oyqc+XId2z9DoPp0YCIvMJBK3A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fKJojBIJnSLQDcommMfPbz/QWXfoA3Fv2yYqw1HKe24D3sk1Y5OyQGFBhPkIKHW7s
         QZec+hd52XlgRjAqvvc/LeVZKRroKhNO544p58SeHe9X8fDJs+fsz129IgDUCdaFEY
         tR1sgonC18Vj/vsi5Z2AuZy1lH2+i8+nj4K9xssg=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230223232827uscas1p2b4e9b7a8cdff173abec72e2e014ec7f4~Gl_HJicyv0509405094uscas1p25;
        Thu, 23 Feb 2023 23:28:27 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id B1.ED.12196.B96F7F36; Thu,
        23 Feb 2023 18:28:27 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230223232827uscas1p20e3b2e7f942b1672d951a2b2cf4ffbc2~Gl_G-F3xc3145231452uscas1p2g;
        Thu, 23 Feb 2023 23:28:27 +0000 (GMT)
X-AuditID: cbfec370-5b3ff70000012fa4-05-63f7f69b73fc
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id AF.38.17110.A96F7F36; Thu,
        23 Feb 2023 18:28:26 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 23 Feb 2023 15:28:26 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        23 Feb 2023 15:28:26 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
Thread-Topic: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
Thread-Index: AQHZR96HF+CoqjnQuUqNMgRXCtZ/Hg==
Date:   Thu, 23 Feb 2023 23:28:26 +0000
Message-ID: <20230223232817.GA469785@bgt-140510-bm01>
In-Reply-To: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <243C179E8C18B44F9A44F36AA3192A56@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzred3Z374nGzQs4LGYPvUCo8X5WadY
        LG5NOMbkwOyxeM9LJo/Pm+QCmKK4bFJSczLLUov07RK4Mlr+fWcpOKBfsW3rIqYGxk1qXYyc
        HBICJhJrtvxi6WLk4hASWMkoMbnpBxuE08ok8eV7NxNM1ed3R9ghEmsZJd7sWAfV8olR4sKl
        ZYwgVUICyxglrixJAbHZBAwkfh/fyAxiiwhoS0yccxDMZhYokfi8ZjtYvbCAt8SptSdZIWp8
        JM5d2sQGYetJ7P3yHcxmEVCVuNfzjAXE5hUwlXi89iiYzSkQJrHg/AawGkYBMYnvp9YwQcwX
        l7j1ZD7U1YISi2bvYYawxST+7XrIBmErStz//pIdol5HYsHuT2wQtp1Eb/NbqDu1JZYtfM0M
        sVdQ4uTMJywQvZISB1fcAHteQmAhh8SLSX1QC1wknm2ZBWVLS/y9uwzqiHyJXW1XoOIVEldf
        d0MdYS2x8M96pgmMKrOQ3D0LyU2zkNw0C8lNs5DctICRdRWjeGlxcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZgajn973DBDsZbtz7qHWJk4mA8xCjBwawkwjuV6XuyEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV5D25PJQgLpiSWp2ampBalFMFkmDk6pBiblmZVFppNlC51+acR3TK07L2DA/EjR
        j+eZEt/RNyf/r19y/8M/Wa8tByPTAqd8mzTr3J3rvGs/RumZ6og9mlshXJ1b1fl5mkz1/6qN
        XNuZJ/QXTLu8X+5RuPOXjS8POJ9/wfOfYyf7oT5Riel6kSKzk2r4BNtPK139WLcs9XSmqFf9
        G+25O6337+XMeTP5eJqmz9s0gZ9P/NjfP75/VJKjcNOBld21k/SYMmQ2+k0/fi5wv3R+vY6N
        zpMkw7Utf5unK97hbWn8cfvBYb+27E8TayKV2rZ1OVY+L94/cU26zn9mtSMJ5ROe2u5JLf0y
        xf46h5GEss0Dlo1bIz4sVbN1vdoi7Lbvulrm0i8M+QFKLMUZiYZazEXFiQBUye8NnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWS2cA0UXfWt+/JBhPnWFlMn3qB0eL8rFMs
        FrcmHGNyYPZYvOclk8fnTXIBTFFcNimpOZllqUX6dglcGS3/vrMUHNCv2LZ1EVMD4ya1LkZO
        DgkBE4nP746wdzFycQgJrGaUmDZpEQuE84lR4nLPD0YIZxmjxO3Pp5hBWtgEDCR+H98IZosI
        aEtMnHMQzGYWKJH4vGY7I4gtLOAtcWrtSVaIGh+Jc5c2sUHYehJ7v3wHs1kEVCXu9TxjAbF5
        BUwlHq89CmYLCYRK3DlyjQnE5hQIk1hwfgNYPaOAmMT3U2uYIHaJS9x6Mp8J4gUBiSV7zjND
        2KISLx//Y4WwFSXuf3/JDlGvI7Fg9yc2CNtOorf5LdTN2hLLFr5mhrhBUOLkzCcsEL2SEgdX
        3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLYKC+1XK84Mbe4NC9dLzk/dxMj
        MC5P/zscvYPx9q2PeocYmTgYDzFKcDArifBOZfqeLMSbklhZlVqUH19UmpNafIhRmoNFSZz3
        ZdTEeCGB9MSS1OzU1ILUIpgsEwenVAPTFt5pn2LqDi2XcN/0yMj98XOjBa6fm4XD5DasOBub
        7hxldWv6wgUKmV6Re7oXhlc3+V7kYJ6fV9ZtH/PA6WHG/MXuy1aarvyx+mf14/07J2SJy/uI
        re5omXtLoHniqSsz7n/5xXrmMMvxCq3Nmds6vnjypPndMfsxOVxZ8r3N1E1KWzyn11e89U5+
        WSqjLJXn1KMdVewtkLXFVLgswMarS3/3EeVsvf89GZtXsf48JhM+J78sIcdA7vbzvB2hb9KL
        nO+tLn7wXGjfqzc3OzfyLr2eeZUpSG/TrYmL3uvtX7/m8buHSzfq6dstfPz33bHohxO3z7Pg
        M1qRvHnDJdewv80aBYvr6ksLO7ZxW0aoKLEUZyQaajEXFScCAG6dSZ86AwAA
X-CMS-MailID: 20230223232827uscas1p20e3b2e7f942b1672d951a2b2cf4ffbc2
CMS-TYPE: 301P
X-CMS-RootMailID: 20230223232827uscas1p20e3b2e7f942b1672d951a2b2cf4ffbc2
References: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
        <CGME20230223232827uscas1p20e3b2e7f942b1672d951a2b2cf4ffbc2@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 23, 2023 at 12:29:02PM -0800, Dan Williams wrote:
> Build a stub version of 'cxl monitor' that reports that the facility was
> statically disabled at configure / build time. Provide the meson
> configuration line to correct the build.
>=20
> This is in response to the fact that some distros fail to ship
> libtracefs-devel even though they ship libtracefs (looking at you CentOS
> Stream 8).
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  config.h.meson    |    3 +++
>  cxl/builtin.h     |    9 +++++++++
>  cxl/meson.build   |   33 +++++++++++++++++++++------------
>  meson.build       |    7 +++++--
>  meson_options.txt |    1 +
>  ndctl.spec.in     |    8 +++++---
>  6 files changed, 44 insertions(+), 17 deletions(-)
>=20
> diff --git a/config.h.meson b/config.h.meson
> index 2852f1e9cd8b..5441dff9fce7 100644
> --- a/config.h.meson
> +++ b/config.h.meson
> @@ -19,6 +19,9 @@
>  /* ndctl test support */
>  #mesondefine ENABLE_TEST
> =20
> +/* cxl monitor support */
> +#mesondefine ENABLE_LIBTRACEFS
> +
>  /* Define to 1 if big-endian-arch */
>  #mesondefine HAVE_BIG_ENDIAN
> =20
> diff --git a/cxl/builtin.h b/cxl/builtin.h
> index 34c5cfb49051..9baa43b8a2ac 100644
> --- a/cxl/builtin.h
> +++ b/cxl/builtin.h
> @@ -22,5 +22,14 @@ int cmd_create_region(int argc, const char **argv, str=
uct cxl_ctx *ctx);
>  int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
>  int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx)=
;
>  int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx)=
;
> +#ifdef ENABLE_LIBTRACEFS
>  int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
> +#else
> +static inline int cmd_monitor(int argc, const char **argv, struct cxl_ct=
x *ctx)
> +{
> +	fprintf(stderr,
> +		"cxl monitor: unavailable, rebuild with '-Dlibtracefs=3Denabled'\n");
> +	return EXIT_FAILURE;
> +}
> +#endif
>  #endif /* _CXL_BUILTIN_H_ */
> diff --git a/cxl/meson.build b/cxl/meson.build
> index fc2e946707a8..391219be76d1 100644
> --- a/cxl/meson.build
> +++ b/cxl/meson.build
> @@ -7,27 +7,36 @@ cxl_src =3D [
>    'memdev.c',
>    'json.c',
>    'filter.c',
> -  'event_trace.c',
> -  'monitor.c',
>  ]
> =20
>  if get_option('systemd').enabled()
>    install_data('cxl-monitor.service', install_dir : systemdunitdir)
>  endif
> =20
> +deps =3D [
> +  cxl_dep,
> +  util_dep,
> +  uuid,
> +  kmod,
> +  json,
> +  versiondep,
> +]
> +
> +if get_option('libtracefs').enabled()
> +  cxl_src +=3D [
> +    'event_trace.c',
> +    'monitor.c',
> +  ]
> +  deps +=3D [
> +    traceevent,
> +    tracefs,
> +  ]
> +endif
> +
>  cxl_tool =3D executable('cxl',
>    cxl_src,
>    include_directories : root_inc,
> -  dependencies : [
> -    cxl_dep,
> -    util_dep,
> -    uuid,
> -    kmod,
> -    json,
> -    versiondep,
> -    traceevent,
> -    tracefs,
> -  ],
> +  dependencies : deps,
>    install : true,
>    install_dir : rootbindir,
>  )
> diff --git a/meson.build b/meson.build
> index 6d2c6827fa88..b4f977f5b7ee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -143,8 +143,10 @@ kmod =3D dependency('libkmod')
>  libudev =3D dependency('libudev')
>  uuid =3D dependency('uuid')
>  json =3D dependency('json-c')
> -traceevent =3D dependency('libtraceevent')
> -tracefs =3D dependency('libtracefs')
> +if get_option('libtracefs').enabled()
> +  traceevent =3D dependency('libtraceevent')
> +  tracefs =3D dependency('libtracefs')
> +endif
> =20
>  if get_option('docs').enabled()
>    if get_option('asciidoctor').enabled()
> @@ -234,6 +236,7 @@ conf.set('ENABLE_TEST', get_option('test').enabled())
>  conf.set('ENABLE_DESTRUCTIVE', get_option('destructive').enabled())
>  conf.set('ENABLE_LOGGING', get_option('logging').enabled())
>  conf.set('ENABLE_DEBUG', get_option('dbg').enabled())
> +conf.set('ENABLE_LIBTRACEFS', get_option('libtracefs').enabled())
> =20
>  typeof_code =3D '''
>    void func() {
> diff --git a/meson_options.txt b/meson_options.txt
> index 4ed519e1f36b..5c41b1abe1f1 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -2,6 +2,7 @@ option('version-tag', type : 'string',
>         description : 'override the git version string')
>  option('docs', type : 'feature', value : 'enabled')
>  option('asciidoctor', type : 'feature', value : 'enabled')
> +option('libtracefs', type : 'feature', value : 'enabled')
>  option('systemd', type : 'feature', value : 'enabled')
>  option('keyutils', type : 'feature', value : 'enabled',
>    description : 'enable nvdimm device passphrase management')
> diff --git a/ndctl.spec.in b/ndctl.spec.in
> index 0543c481da7f..7702f9552cd0 100644
> --- a/ndctl.spec.in
> +++ b/ndctl.spec.in
> @@ -13,9 +13,13 @@ BuildRequires:	autoconf
>  %if 0%{?rhel} < 9
>  BuildRequires:	asciidoc
>  %define asciidoctor -Dasciidoctor=3Ddisabled
> +%define libtracefs -Dlibtracefs=3Ddisabled
>  %else
>  BuildRequires:	rubygem-asciidoctor
> +BuildRequires:	libtraceevent-devel
> +BuildRequires:	libtracefs-devel
>  %define asciidoctor -Dasciidoctor=3Denabled
> +%define libtracefs -Dlibtracefs=3Denabled
>  %endif
>  BuildRequires:	xmlto
>  BuildRequires:	automake
> @@ -31,8 +35,6 @@ BuildRequires:	keyutils-libs-devel
>  BuildRequires:	systemd-rpm-macros
>  BuildRequires:	iniparser-devel
>  BuildRequires:	meson
> -BuildRequires:	libtraceevent-devel
> -BuildRequires:	libtracefs-devel
> =20
>  %description
>  Utility library for managing the "libnvdimm" subsystem.  The "libnvdimm"
> @@ -124,7 +126,7 @@ libcxl is a library for enumerating and communicating=
 with CXL devices.
>  %setup -q ndctl-%{version}
> =20
>  %build
> -%meson %{?asciidoctor} -Dversion-tag=3D%{version}
> +%meson %{?asciidoctor} %{?libtracefs} -Dversion-tag=3D%{version}
>  %meson_build
> =20
>  %install
>=20
>

Heads up, I just built ndctl devel branch on tumbleweed and libtracefs-dev
puts include files in libtracefs/tracefs.h
