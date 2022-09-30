Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB98C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Sep 2022 21:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiI3VXl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiI3VXk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 30 Sep 2022 17:23:40 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860F1BC62F
        for <linux-cxl@vger.kernel.org>; Fri, 30 Sep 2022 14:23:35 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220930212330usoutp011b59bbbe8fd6a996c857efbb58b37a0b~ZwFV2zTJC1562815628usoutp01M;
        Fri, 30 Sep 2022 21:23:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220930212330usoutp011b59bbbe8fd6a996c857efbb58b37a0b~ZwFV2zTJC1562815628usoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664573010;
        bh=9eZYvlcDE0aaAQvv+KvXqFAK0TrWwL3+3s8LiBiTcJw=;
        h=From:To:CC:Subject:Date:References:From;
        b=vFSnirczZsutIBDj+1rO/cPRkqsZutzziJmEGLZAhuYZ9GEORd4p/7WV3iMtuxGvT
         Q2CCC0mH8UK5nO8/tTm0oUYnw4Uz9SdY75zdUnDFJPbR16PNSHt12sbLyuF5Rezs7k
         0ytMbQOIzi4f+GYSRNdZttgRdhkk309i/IKbahjU=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220930212330uscas1p1acb3b65376e590918f3beff66a461ccf~ZwFVusYIw1869018690uscas1p11;
        Fri, 30 Sep 2022 21:23:30 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 8F.37.18126.25E57336; Fri,
        30 Sep 2022 17:23:30 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220930212330uscas1p1363cbba1dc87b5442317e74fa861ae9d~ZwFVaCYF10405604056uscas1p1B;
        Fri, 30 Sep 2022 21:23:30 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-e9-63375e5288ab
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id CC.B4.19363.15E57336; Fri,
        30 Sep 2022 17:23:30 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 30 Sep 2022 14:23:29 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        30 Sep 2022 14:23:29 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [fan.ni@samsung.com: Re: [ndctl PATCH 1/2] cxl: Add root port
 attribute to cxl list output]
Thread-Topic: [fan.ni@samsung.com: Re: [ndctl PATCH 1/2] cxl: Add root port
        attribute to cxl list output]
Thread-Index: AQHY1RLiQ3jQJ7khl0+IGdjzZ5ClOw==
Date:   Fri, 30 Sep 2022 21:23:29 +0000
Message-ID: <20220930212315.GA2896523@bgt-140510-bm03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3155ABECF7AA7A4A94CFF2F67E862D01@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djXc7pBcebJBqfeCFlMn3qB0WL1zTWM
        FudnnWKxaPy5iNHi1oRjTA6sHjtn3WX3WLznJZPH1Nn1Hp83yQWwRHHZpKTmZJalFunbJXBl
        3P34j61gV1ZF+4rrrA2Mm6O6GDk5JARMJC7t38vUxcjFISSwklHi3ZvVzBBOK5PE2k3TWGGq
        5p+cxg6RWMsoMf/1fkYI5xOjROfk3VCZZYwStw7eZANpYRNQlNjXtR3MFhGwlNj+bRsLSBGz
        wD+gJfMeM4IkhAXSJJo3zWSBKMqW+HHrOFSDnsTJzh6gQzg4WARUJVZNsgAJ8wqYSfw4eBes
        nFFATOL7qTVMIDazgLjErSfzmSBOFZRYNHsPM4QtJvFv10M2CFtR4v73l+wQ9XoSN6ZOYYOw
        7SROXb/CCGFrSyxb+JoZYpegxMmZT1ggeiUlDq64AXa/hMBKDol1zy5ALXOR6Ft4GRpG0hJX
        r0+FWlwtcabnHBNEQwujxKXGzVAJa4l/ndegruCT+PvrEeMERuVZSJ6YheTAWUgOnIXkwFlI
        DlzAyLqKUby0uDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMAmd/nc4fwfj9Vsf9Q4xMnEwHmKU
        4GBWEuH15jVPFuJNSaysSi3Kjy8qzUktPsQozcGiJM4bNUMrWUggPbEkNTs1tSC1CCbLxMEp
        1cC0/ijPZVPuNavDMkzzNsiGSk8pu2QbWHFiVrNc1N+5SybtmpvC8ub0kuN371/q//yt4f+3
        R9fWLXt5W1Zt4g5OtizH6IZzj1/p61zmTHritnKJouKPFWUJX2LKnFKjim+X37znOWnXz5CN
        J/32GLvLTUxhvThx54Nf56/krWM7M2tt+AW5+ZpBmZN2aT2+1HH4/IZQ+Y6rn+90aImcsznf
        qmGTn/BR08zrdilrF+/OpA4+ZZHPfoY75zlUXLtv8+plVfeVrM5IvYWza/w/xZk/Pbkk6vR2
        o5bPUW7z/jYWv2oxc3FpW7drabHjN0uTKO8yV/ZM3ndveDJUFBY+LD78bdt6jgMuR5z2qJ7c
        JNujrMRSnJFoqMVcVJwIACwpZD6xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWS2cA0STcozjzZ4Pc0RovpUy8wWqy+uYbR
        4vysUywWjT8XMVrcmnCMyYHVY+esu+wei/e8ZPKYOrve4/MmuQCWKC6blNSczLLUIn27BK6M
        ux//sRXsyqpoX3GdtYFxc1QXIyeHhICJxPyT09i7GLk4hARWM0qs6zzPCOF8YpRYf2MqC4Sz
        jFFiZ9suVpAWNgFFiX1d29lAbBEBS4nt37aBFTEL/GOUaJs4mRkkISyQJtG8aSYLRFG2xIZ7
        15ghbD2Jk509QDYHB4uAqsSqSRYgYV4BM4kfB++ClTMKiEl8P7WGCcRmFhCXuPVkPhPEqQIS
        S/acZ4awRSVePv7HCmErStz//pIdol5P4sbUKWwQtp3EqetXGCFsbYllC18zQ+wSlDg58wkL
        RK+kxMEVN1gmMIrNQrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst1ytOzC0uzUvX
        S87P3cQIjMbT/w5H7mA8euuj3iFGJg7GQ4wSHMxKIrzevObJQrwpiZVVqUX58UWlOanFhxil
        OViUxHmFXCfGCwmkJ5akZqemFqQWwWSZODilGphkc80MmWO5TrlE3BWfLl5+7CG7/cJLZ7/H
        /bjhYKq4dhGj96FXulxfboaE7dRZv3HNunXCvxPezlM+2xl3ztq04Ki1rpttwuG3M7Y/cuQs
        EfI7pKLnekYjWn3pv/XXW/bpr9yivka9Qei1B+cBI17HKZb1oeohCyMbpBgzcpKj7+xj0vua
        p+p88KzYSoXpUufEa9XNNi/9Jyn9SNmlNN2TcfFXl3tHrdjD/s1vrupYlhf2Yo3Kpz8Pd/5O
        KoxY4xa+VE77jqOUvZqz8ovnew5JZif945mRzLTYTr0g+bDmjH1/6wp/Tdm7i8Fju+DdXUIx
        z8wdVPi2Tyxu3zK973v4m4aXDR6Cs5+rf1z4sFeJpTgj0VCLuag4EQDpB2bUNQMAAA==
X-CMS-MailID: 20220930212330uscas1p1363cbba1dc87b5442317e74fa861ae9d
CMS-TYPE: 301P
X-CMS-RootMailID: 20220930212330uscas1p1363cbba1dc87b5442317e74fa861ae9d
References: <CGME20220930212330uscas1p1363cbba1dc87b5442317e74fa861ae9d@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On Fri, Sep 09, 2022 at 10:10:04PM +0000, Verma, Vishal L wrote:

> On Fri, 2022-08-19 at 01:54 -0700, sunfishho12@gmail.com wrote:
> > From: Matthew Ho <sunfishho12@gmail.com>
> >=20
> > This adds a "root port" attribute to ports and type 3 memory devices
> > located under a host bridge indicating which root port each device
> > falls under. Previously, the cxl list command lists the various root
> > ports as dports underneath each host bridge, and displays devices as
> > being under a given host bridge, but did not indicate which specific
> > root port corresponded to which device. Adding this information
> > helps to map the CXL topology.
>=20
> Hm is this patch actually needed - the json output can already list
> port hierarchies. So would it instead be possible to have a 'walk to
> root' helper that the graphing functions can instead call each time.
>=20
> A library helper to get to the root port each time would be better than
> just adding it to the JSON output, as that seems redundant.
>=20
In current cxl list output, the dports and memdevs under a specific port ar=
e
put at the same level in the hierachy. As shown in the below example, dport=
s=20
and memdevs:port1 are put side by side at the same level under ports:root0 =
in=20
the json layout.
With that being said, information showing which memdev is attached to which=
=20
dport is missing in current cxl list json output. If there is only one dpor=
t,=20
that is fine, but if there are multiple dports and memdevs under the same p=
ort,=20
with current json output we cannot figure out which memdev is attached to=20
which dport directly.=20
Adding root port info to the output can help users better understanding the=
 cxl
hierachy. In the patch, a new attribute "root port" is added to memdev and =
port
to track the info, if it is not desirable, we can try two alternate solutio=
ns=20
to achieve similar goal so we can plot the complete hierachy.
1. add extra attribute "home path" for memdev and "uport" for port json obj=
ect,
	from where we can extract "root port" info.
2. If we want to keep the current cxl list program flow intact as much as=20
possible, we can create separate json objects with root port info=20
for ploting hierachy purpose. However, with this apporach, we may have=20
duplicate code snippets.

Which approach do you prefer? Or you come up with something else?

"ports:root0":[
{
	"port":"port1",
		"host":"ACPI0016:00",
		"depth":1,
		"nr_dports":2,
		"dports":[
		{
			"dport":"0000:de:00.0",
			"id":"0"
		},
		{
			"dport":"0000:de:01.0",
			"id":"0x1"
		}
		],
		"memdevs:port1":[
		{
			"memdev":"mem1",
			"pmem_size":"256.00 MiB (268.44 MB)",
			"ram_size":0,
			"serial":"0",
			"host":"0000:e0:00.0"
		},
		{
			"memdev":"mem0",
			"pmem_size":"256.00 MiB (268.44 MB)",
			"ram_size":0,
			"serial":"0",
			"host":"0000:df:00.0"
		}
		]
}

	> Otherwise some general comments below:
	>=20
	> >=20
	> > Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
	> > ---
	> > =A0cxl/json.c=A0=A0=A0=A0=A0=A0=A0=A0 | 16 ++++++++++-
	> > =A0cxl/lib/libcxl.c=A0=A0 | 66 +++++++++++++++++++++++++++++++++++++++=
+++++++
	> > =A0cxl/lib/libcxl.sym |=A0 3 ++-
	> > =A0cxl/libcxl.h=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> > =A04 files changed, 85 insertions(+), 2 deletions(-)
	> >=20
	> > diff --git a/cxl/json.c b/cxl/json.c
	> > index 9cec58b482b6..ad82f37fc955 100644
	> > --- a/cxl/json.c
	> > +++ b/cxl/json.c
	> > @@ -303,7 +303,7 @@ err_jobj:
> > =A0struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memde=
v,
		> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long flags)
	> > =A0{
> > -=A0=A0=A0=A0=A0=A0=A0const char *devname =3D cxl_memdev_get_devname(me=
mdev);
> > +=A0=A0=A0=A0=A0=A0=A0const char *devname =3D cxl_memdev_get_devname(me=
mdev), *rp;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct json_object *jdev, *jobj;
> > =A0=A0=A0=A0=A0=A0=A0=A0unsigned long long serial;
> > =A0=A0=A0=A0=A0=A0=A0=A0int numa_node;
> > @@ -324,6 +324,13 @@ struct json_object *util_cxl_memdev_to_json(struct=
 cxl_memdev *memdev,
> > =A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0json_object_object_add(=
jdev, "ram_size", jobj);
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0rp =3D cxl_memdev_get_root_port(memdev);
> > +=A0=A0=A0=A0=A0=A0=A0if (rp) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jobj =3D json_object_new_=
string(rp);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0j=
son_object_object_add(jdev, "root port", jobj);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0if (flags & UTIL_JSON_HEALTH) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jobj =3D util_cxl_memde=
v_health_to_json(memdev, flags);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > @@ -727,6 +734,7 @@ static struct json_object *__util_cxl_port_to_json(=
struct cxl_port *port,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 unsigned long flags)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0const char *devname =3D cxl_port_get_devname(po=
rt);
> > +=A0=A0=A0=A0=A0=A0=A0const char *rp =3D cxl_port_get_root_port(port);
> > =A0=A0=A0=A0=A0=A0=A0=A0struct json_object *jport, *jobj;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0jport =3D json_object_new_object();
> > @@ -741,6 +749,12 @@ static struct json_object *__util_cxl_port_to_json=
(struct cxl_port *port,
> > =A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0json_object_object_add(=
jport, "host", jobj);
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0if (rp !=3D NULL) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jobj =3D json_object_new_=
string(rp);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0j=
son_object_object_add(jport, "root port", jobj);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0if (!cxl_port_is_enabled(port)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0jobj =3D json_object_ne=
w_string("disabled");
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (jobj)
> > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > index a40b0e6aee83..c5b8ff339eb8 100644
> > --- a/cxl/lib/libcxl.c
> > +++ b/cxl/lib/libcxl.c
> > @@ -1260,6 +1260,39 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram=
_size(struct cxl_memdev *memdev)
> > =A0=A0=A0=A0=A0=A0=A0=A0return memdev->ram_size;
> > =A0}
> > =A0
> > +CXL_EXPORT const char *cxl_memdev_get_root_port(struct cxl_memdev *mem=
dev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0char *rp_name =3D strdup(memdev->host_path), *sav=
e;
> > +=A0=A0=A0=A0=A0=A0=A0const char *rp;
> > +=A0=A0=A0=A0=A0=A0=A0bool host_bridge_found =3D false;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!memdev->host_path)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0rp_name =3D strdup(memdev->host_path);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!rp_name) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printf("Error: strdup fai=
led in cxl_memdev_get_Root_port\n");
>=20
> As a general rule, only JSON formatted output goes to stdout.
> Everything else goes to stderr, and use the logging helpers (e.g.
> dbg(), err(), etc. ) for any output from libcxl, so that if logging is
> being redirected to something other than stderr, everything stays
> consistent.
>=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0rp =3D strtok_r(rp_name, "/", &save);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0while (rp) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* return the first subst=
ring after the host bridge */
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (host_bridge_found)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn (char *)rp;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!strncmp(rp, "pci", s=
trlen("pci")))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0h=
ost_bridge_found =3D true;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rp =3D strtok_r(NULL, "/"=
, &save);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +}
> > +
> > +
> > =A0CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_me=
mdev *memdev)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0return memdev->firmware_version;
> > @@ -2405,6 +2438,39 @@ CXL_EXPORT const char *cxl_port_get_host(struct =
cxl_port *port)
> > =A0=A0=A0=A0=A0=A0=A0=A0return devpath_to_devname(port->uport);
> > =A0}
> > =A0
> > +CXL_EXPORT const char *cxl_port_get_root_port(struct cxl_port *port)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0char *rp_name, *save;
> > +=A0=A0=A0=A0=A0=A0=A0const char *rp;
> > +=A0=A0=A0=A0=A0=A0=A0bool host_bridge_found =3D false;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!port->uport)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0rp_name =3D strdup(port->uport);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!rp_name) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printf("Error: strdup fai=
led in %s\n", __func__);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0rp =3D strtok_r(rp_name, "/", &save);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0while (rp) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* return the first subst=
ring after the host bridge */
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (host_bridge_found)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn (char *)rp;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!strncmp(rp, "pci", s=
trlen("pci")))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0h=
ost_bridge_found =3D true;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rp =3D strtok_r(NULL, "/"=
, &save);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +}
> > +
> > +
> > =A0CXL_EXPORT bool cxl_port_hosts_memdev(struct cxl_port *port,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_memdev *memdev)
> > =A0{
> > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > index 549f88dae6ff..4f61686a3aff 100644
> > --- a/cxl/lib/libcxl.sym
> > +++ b/cxl/lib/libcxl.sym
> > @@ -19,6 +19,7 @@ global:
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_ctx;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_pmem_size;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_ram_size;
> > +=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_root_port;
>=20
> The way the symbol script works is that each release gets a new
> 'section' for all the symbols that it adds. So v74's new symbols were
> added to the 'LIBCXL_3' section. If this is targeting the next, v75
> release, its new APIs will go into a new section - LIBCXL_4. If
> LIBCXL_4 already existed on the pending branch, you can append into
> that section at the bottom. But in this case since it doesn't exist,
> you can create one, and add the new APIs in this patch there.
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_firmware_verison;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_cmd_get_devname;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_cmd_new_raw;
> > @@ -101,7 +102,7 @@ global:
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_to_endpoint;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_get_bus;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_get_host;
> > -=A0=A0=A0=A0=A0=A0=A0cxl_port_get_bus;
>=20
> Was this deletion accidental?
>=20
> > +=A0=A0=A0=A0=A0=A0=A0cxl_port_get_root_port;
>=20
> Same as above regtarding the new section - there's no need to group
> port things vs memdev things in this file.
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_hosts_memdev;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_get_nr_dports;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_port_disable_invalidate;
> > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > index 61c7fc4e39b8..9ffa640bc832 100644
> > --- a/cxl/libcxl.h
> > +++ b/cxl/libcxl.h
> > @@ -47,6 +47,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
> > =A0struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
> > =A0unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memde=
v);
> > =A0unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev=
);
> > +const char *cxl_memdev_get_root_port(struct cxl_memdev *memdev);
> > =A0const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memde=
v);
> > =A0size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
> > @@ -95,6 +96,7 @@ bool cxl_port_is_endpoint(struct cxl_port *port);
> > =A0struct cxl_endpoint *cxl_port_to_endpoint(struct cxl_port *port);
> > =A0struct cxl_bus *cxl_port_get_bus(struct cxl_port *port);
> > =A0const char *cxl_port_get_host(struct cxl_port *port);
> > +const char *cxl_port_get_root_port(struct cxl_port *port);
> > =A0bool cxl_port_hosts_memdev(struct cxl_port *port, struct cxl_memdev =
*memdev);
> > =A0int cxl_port_get_nr_dports(struct cxl_port *port);
> > =A0int cxl_port_disable_invalidate(struct cxl_port *port);
>=20

----- End forwarded message -----=
